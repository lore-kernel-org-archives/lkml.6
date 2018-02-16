Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-684122-1518803839-2-16972250682577802682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518803839; b=EcTTjbcWJXHaTvSU8M2RowWQ7z5e+SRuY/ikFwOIQXYr0b9
    QuLytXuvvjKXfTKmblCpnz60m4QrzXy/teFaKiso6ilKlmeBZTR1P7G+sRNs3PvD
    3c4BV9ErBifbSOnBuH+fOBln6wUV8XcyVkFXRKe6Ki5e8dmpTt2dkYz1EZRw9Ln2
    X0g+MkcZPr55fQ9nQ8CT89GjE3XSQfCbLNJpKm+/mdJoCVUd2ocq5BGSrnZCGJ/S
    c6OWzkEKJranlP6A4H5e/Gcj1oksQdQbdMCmkRLkEtpd4Yn44GP8d6cbCce6XuDt
    /piWg8ChU/5e/kznCSq40v5wt/U8ZkUiLJkZOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518803839; bh=j
    eZ7tpduTlNuKRL+yAgTSkX0L9hVLtZJCyrZZCqiZK8=; b=DG4Q+OOoQnYlee+oE
    jP9st2rLvvCn0vhTfvMd3XlyxygubqVfFATwtISQNedk8sa++ULkiaDQAQicea6q
    E/lf4RhEmd6lsBYuWkxClFwdsMoax4WVdr6SmZG0iQXQE4WtgbPaBbsRdQLpx5Q5
    tYpHr/rna4ps2H/EuguHA2bToc83DiEr6JM7fgHnDqnQMGn2Ff7/F5DYfGRR4xFj
    eHTVjWBTmlD7zQ7X5bjqildpnoAiVkAw/Nh0FcY+LGUXi4uPyvsaiiioWlcfxl5l
    +yAz8Oy0d5Iwi0HSaCQgcna0tbqL47bjSRrm4epBHNr9SizXh0dwws/Ad4jYK1UR
    G9ZtA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=TXRCWFAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=TXRCWFAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=TXRCWFAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=TXRCWFAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2226360558
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Fri, 16 Feb 2018 09:57:12 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
In-Reply-To: <20180216162353.GA13019@kroah.com>
Message-ID: <alpine.DEB.2.02.1802160956030.20374@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
 <20180216162353.GA13019@kroah.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018, Greg KH wrote:

> On Fri, Feb 09, 2018 at 10:16:56PM -0800, Liam Mark wrote:
> > Fix the dup_sg_table function to initialize the dma_address of the new
> > sg list entries instead of the source dma_address entries.
> > 
> > Fixes: 17fd283f3870 ("staging: android: ion: Duplicate sg_table")
> 
> So this should be sent to the stable trees as well, right?
> 
> Please add that when you resend...

My understanding was that I should only send this to the stable branch if 
it fixes a real bug.

Both myself and Laura can't see any actual problems that result from this 
issue, the change is more to help future proof the code.

My commit message wasn't clear about this and could have mislead people 
into thinking there was a bug.
I will update the commit message to make it clear that this issue doesn't 
currently result in any problem.

Do you still want me to send it to the stable trees?

Thanks,
Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
