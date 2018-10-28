Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1073C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784F020672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784F020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJ2FoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:44:18 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeJ2FoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:44:18 -0400
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue011
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N2Ujn-1fZsnY1V1z-013sBS; Sun, 28
 Oct 2018 21:58:07 +0100
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue011
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N2Ujn-1fZsnY1V1z-013sBS; Sun, 28
 Oct 2018 21:58:07 +0100
Date:   Sun, 28 Oct 2018 21:58:05 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <1557548417.4198.1540760285645@email.ionos.de>
In-Reply-To: <20181026134813.7775-16-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-16-nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 15/18] stagning: vchiq_core: fix logic redundancy in
 parse_open
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:I3GLNwAwkV0wcWMkv4aYnQZgFsqeSPiOIAnlhq9hzrk4zcUpype
 6APws1ReClMPpPWL3QrCQtfsdZyp3k+0SA0uigPdChuGLxw87K3Cmtd9f9S7MqcHhpMFXIy
 K/v7lZ0YzC0Ur/G2fUXfMyI3pmwieRNDqfh4ptC/CsD+wtZD8mjNm9GYYHBeP+LjAxqTVLu
 L1zO/BRFnj2lpd+lZKSIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ha49mrMpnWc=:OBGQanqFx0S6IOA7FWAwV4
 VBrriuFSjclQxMFHPdjZ0Z0RINMznONVatsN4BP+w9BBD2wUlQuKyxj7lCQJPcqiHHWhi+wfC
 SPvPiExxB01WhZZDpbEcN5expXYiGtoqXXwsoSRMdLrrVmd67d345Yvh9qH1FT0jYO5z1NMiJ
 RzEEiAhJ+mSV/I9JwKLBi0A1E65R/a2b8OHcRqDBmo3CbgEreBlK0RRbnoToNq1jTxuwDn1rF
 4knHFQa8auOH6aWn4r0tVtkaMDuopMvev4qLpah48ueMM77dLLNOgaZGCZtQQNk141xXXF+VL
 VhoQvb6gKaG89H+sYApkzXRnAc3DNzQTiiu5xD787q8/SYNrIzETbEtGZ+oHk9eI8ujTdkiI9
 4dTfo2dyvGZw/r/8V9XaHq3v+p+gVk+LP1dkwlVkbvFT3rz6s/Q+SfRCd6KUQhv9pwURvjdOR
 qijmIAX4Ye26L6PN/jCFWCQhVxsNskOaLAZK0SE1mvGymKmrRiMzQQTQOqDW9iiV7rS5vG1xD
 7QZyfcZQaw7H+aybXQiZQaj/kAidkzSQJITKcAU1STlS4xbBsypDFR6zC9EI73Lkxrb8xpCws
 SE06GLyFSfLtit5geSx0zJ+Bqx7BPjMuqcU0FX3Xr66UJ+ngIppX302bYoybagCHHbm5k6bMG
 DJnGNbmX1lORRqPZEsRhLYjMvtiV+q+4k5DSq+rYJjl1eWaK7tF0ZngHZzu0X2/Q4rhkgpkqt
 2O3O62u7oc1bg6bI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> We update sync to reflect that the firmware version is compatible with
> that option. We don't need to check both of them again further down the
> code.

please fix the typo in the subject s/stagning/staging/ for this patch and patch #4
