Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA85C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ze-it.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeLMCVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:21:22 -0500
Received: from vie01a-dmta-pe06-1.mx.upcmail.net ([84.116.36.14]:30744 "EHLO
        vie01a-dmta-pe06-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbeLMCVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:21:21 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <thomas.zeitlhofer@ze-it.at>)
        id 1gXGco-0002Gx-Nm
        for linux-kernel@vger.kernel.org; Thu, 13 Dec 2018 03:21:18 +0100
Received: from localhost.localdomain ([80.108.25.171])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id XGcogU0R75WeQXGcoge5AQ; Thu, 13 Dec 2018 03:21:18 +0100
X-Env-Mailfrom: thomas.zeitlhofer@ze-it.at
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 80.108.25.171
X-CNFS-Analysis: v=2.3 cv=YaJsGDZf c=1 sm=1 tr=0
 a=cw3iLm2b3cPoAt0NIr38/g==:117 a=cw3iLm2b3cPoAt0NIr38/g==:17
 a=8nJEP1OIZ-IA:10 a=foHCeV_ZAAAA:8 a=YfNDvM6DVzzMtkwtuQYA:9 a=wPNLvfGTeEIA:10
 a=nO2_vQ5IkrQA:10 a=h8a9FgHX5U4dIE3jaWyr:22
Date:   Thu, 13 Dec 2018 03:21:07 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
To:     Hui Wang <hui.wang@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4.19 096/139] ALSA: hda/realtek - fix the pop noise on
 headphone for lenovo laptops
Message-ID: <20181213022107.GA4450@x1>
References: <20181204103649.950154335@linuxfoundation.org>
 <20181204103654.341269777@linuxfoundation.org>
 <20181212234517.GA15065@x1>
 <1fe3ba5d-d77a-4592-c5c9-67d788d8b434@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fe3ba5d-d77a-4592-c5c9-67d788d8b434@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfM/ylFTqUsZwbQr5lIXZHMFD4jKb5V3fsUt5i2z6Gj5Wp/E59eFhvCbxrbkky2hIYb15uwkNTKbl9e2aqmmf66ZcYABF0miLGjw1V5C3se8u3GvQoXsD
 zaYru5G2goyG3Ug1zP+Uvb9kNMa0VQvWJAYCQFiFeY/4pt3vCzNqVPvL+lb+FYSlQ+wtU9HKItaATnIuJSBcDRYz9JQpyT5fByIhLOqLckMgcjn/Vv7LD27d
 a7pIP/LNGdV9xBs0dd+3zKGEqXiHNK0OLnpymhu06QaNUoUOFMTuhDAe5W+hLuqwwEUyu1O6fJqgRaH9VyTEEZ3+w53rm3gzev392RXXS1ViF1Tonz84I84B
 gLGK0VkC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hui,

On Thu, Dec 13, 2018 at 08:23:40AM +0800, Hui Wang wrote:
> Hello Thomas,
> 
> I have sent a new patch to fix this LED regression, after applying
> this patch (ALSA: hda/realtek - fix the pop noise on headphone for
> lenovo laptops) and the new patch (ALSA: hda/realtek - Fix the mute
> LED regresion on Lenovo X1  Carbon),  the issue will be fixed.
> 
> This is the new patch I sent (also CCed to stable):
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/142747.html

thanks, I can confirm that this fixes the LED regression.

> About the noise, if you follow the steps as below, you would hear the
> noticeable click/pop noise:
> 
> 1. Hookup a set of headphones that you can separately place in/on your
> ears.  (ie. ear buds)
> 
> 2. Put only the right headphone in/on your ear.
> 
> 3. Go to the Gnome sound settings and bring up the "Test Speakers"
> function
> 
> 4. Play the left speaker test
> 
> You would expect to hear nothing in the right ear, but instead you
> hear a "pop" at the start of each word spoken. ("pop" Front "pop"
> left). You can repeat with the left headphone and see similar results.
> I even tried shifting the balance all the way to the left/right and
> get the same results.

Thank you for elaborating on the noise problem - now I could also
reproduce it and see that your patch (ALSA: hda/realtek - fix the pop
noise on headphone for lenovo laptops) fixes it.

Regards,

Thomas
