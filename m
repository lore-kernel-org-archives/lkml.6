Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243332-1523345934-2-14818856113103745444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523345933; b=NT4nKGzvYr+HKGeVtKBhb+1tqmn/HHawtnp05g3TBucF0rIsBT
    4cMlFM4uelvPlznQNhuiV4JJEDOlex5Ex2g3Fxd079xb3OHPMNP4mRPWjOUWg3Dt
    7Rprabxge7ok1KVTlrxGhch4d2AYQ8ZwlWtj1xu1DaH00eNIcN1aikFJjTN4QQFQ
    mwt0aFp59BfwPxzmorGS2LVli6woQsnV/b0sBurGwa7jMsq8Udyr/9EFxUfFR7Nl
    urShb59b4pGhc/ShesG4QMMX36nqBttc3+1SNMHfbhU612SOIiUkmodj3MNqyezZ
    I1qJFhprZDRWgAPPl1KL02KdSi2l4hnBg1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523345933;
    bh=jef6HSEVVVe2f409zxc/YCcGKgPcW0d4O0bobJQl8R0=; b=CIM/nDMXh425
    YbYPdcY3hWecnZhbMi8WLpYQc7fXmpYrSbgoGNW4n8wTHnEs5mT/a39Vy/I1y33P
    BrOoHCfTD0D8gvCos59TsUZ7zrbXMhiPWkEf+s5i063NH+HGVtTZX1my79FCDava
    oYQSEHLUlOua87ivApth9h9wGf4cySXJxDVePc4x8szvZ3P2n4WUTTSUUKJuOgx4
    +hqSRZx1radH9yAjJ2VUUjoL22unedCGUaJBhPeKqt9mT5Xw0+RbQB67e6bIkF+8
    emyeryq03lpCA/BwDZKBThws+5SBSBf99tFoR3k6g8+WXXJ/uR28dyWthBXjkU9Y
    F3dGseBzqA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ6WdqzLTWIlP815TEJsN/Y7QB29HNURkdcDDJyI/XClzabFGHA2GJWON+E6TRi7RDmIbTzL5ZFhzhBBydOdlIV6u9T1BAQqOv5u6JFCZWBNAk+0so+D
    c/d1rI+7Vkj4zWrJFcFai6NHNc0Q+lvdzcAE9xidqTY6VpSdlUZEUWqGYmZauyzpnMdRlSDwpD77Abt8JFSvygLMAmi+dgRwUMai0rVZDAwDVRrv8TDcWKmD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=OLL_FvSJAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gkQ_UJd7ExqEbFQ8lzoA:9
    a=3rZ6wqZFvqVb3igR:21 a=PFJs7xQE0bh8NSXF:21 a=CjuIK1q_8ugA:10
    a=Ey0gUAR8-osA:10 a=7bBtgmo6PNIA:10 a=oIrB72frpwYPwTMnlWqB:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDJHil (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:38:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752181AbeDJHij (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 10 Apr 2018 03:38:39 -0400
Date: Tue, 10 Apr 2018 09:38:36 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, benjamin.tissoires@redhat.com,
        andyrtr@archlinux.org, aduggan@synaptics.com,
        stable@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: i801: blacklist Host Notify on HP EliteBook G3
 850
Message-ID: <20180410093836.1e39d9d8@endymion>
In-Reply-To: <20180405183824.13333-1-jandryuk@gmail.com>
References: <20180404225643.6b40782f@endymion>
        <20180405183824.13333-1-jandryuk@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  5 Apr 2018 14:38:24 -0400, Jason Andryuk wrote:
> The HP EliteBook G3 850 has a weird bug where a subsequent cold boot
> hangs while plugged in if Linux enables the Host Notify features of
> i2c-i801.  The cold boot hang depends on how the system boots.  It does
> not hang on UEFI Grub text boot or legacy Grub text boot.  But it does
> hang on legacy Grub graphical boot and Intel Boot Agent PXE text boot.
> Booting unplugged is not affected.
> 
> Disabling the Host Notify feature with disable_feature=0x20 works around
> the bug, so automatically do so based on DMI information.
> 
> More information can be found here:
> https://www.spinics.net/lists/linux-i2c/msg33938.html
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Cc: stable@vger.kernel.org
> ---
> v3: Switch to DMI_EXACT_MATCH and add empty element to array
> 
>  drivers/i2c/busses/i2c-i801.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> (...)

Wolfram and stable, please hold on with this patch, Jason and I may have
found a proper fix so blacklisting would no longer be needed.

-- 
Jean Delvare
SUSE L3 Support
