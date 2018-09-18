Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1037ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC1B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="ANTCcGY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC1B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeIRHIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:08:25 -0400
Received: from st14p23im-asmtp003.me.com ([17.164.101.13]:45320 "EHLO
        st14p23im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeIRHIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:08:25 -0400
X-Greylist: delayed 3612 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 03:08:24 EDT
Received: from process-dkim-sign-daemon.st14p23im-asmtp003.me.com by
 st14p23im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PF800O006TDMX00@st14p23im-asmtp003.me.com>; Tue,
 18 Sep 2018 00:38:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1537231100; bh=sd7BnCTIuB6QsPKifQZfeW2sQKoRHH5pxGY/thMdjKI=;
        h=Content-type:MIME-version:Subject:From:Date:Message-id:To;
        b=ANTCcGY61Z2EYLuC262KP3R30MyIKfaRqyqaVvDIDNsEfq2TicKAyAgVWtjGZ9txh
 rToaNMlKYGIZdT2g2uTu5LTdykYIW1wWS/vqbnJcbtxkhUHprKLnGsHnwjBPyqdgf7
 RFz8oZXkOC4EFuwTZ1s9Asa8OdlYIV2c8xwEllCJDCd35Hx2x2WgQ1hc6OrDL22IPr
 mSpgUTFHPDSdG0rSqzCmswstgPFrn9NFikWQXojg8xPpu8KRuX3hbu0xZqhLB02TAk
 evttZ44meU2ds+HI4rB7cTz34jcmmS09j0Vx/FUC/Lg1UdU/8RD+aGtCGjSDr+ZVfJ
 qzkn6mSFAh1aA==
Received: from icloud.com ([127.0.0.1]) by st14p23im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PF801B2673URA20@st14p23im-asmtp003.me.com>; Tue,
 18 Sep 2018 00:38:20 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180004
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-09-17_13:,, signatures=0
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCHv2 2/2] scsi: ibmvscsis: Ensure partition name is properly
 NUL terminated
From:   Bryant Ly <bryant.ly@me.com>
In-reply-to: <20180911192226.3620-3-labbott@redhat.com>
Date:   Mon, 17 Sep 2018 19:38:17 -0500
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-transfer-encoding: 7bit
Message-id: <8E56DEE3-6A6D-49E5-81D0-0E26CDBC28A6@me.com>
References: <20180911192226.3620-1-labbott@redhat.com>
 <20180911192226.3620-3-labbott@redhat.com>
To:     Laura Abbott <labbott@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2018, at 2:22 PM, Laura Abbott <labbott@redhat.com> wrote:
> 
> While reviewing another part of the code, Kees noticed that the
> strncpy of the partition name might not always be NUL terminated. Switch
> to using strscpy which does this safely.
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> v2: Switch to strscpy instead of just strlcpy
> ---
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Bryant G. Ly bly@catalogicsoftware.com

I sent a PR to update my email from bryantly@linux.vnet.ibm.com a week ago.

-Bryant

