Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-382436-1524057707-2-8955024673756887682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524057706; b=mM2JedW6En+h8CDX2X6stNoc2yGinX5PUbPnIgfoEwueJFCLBF
    p0640Xmu1bCxuzl18fYgVvV8EaxH7DE6DHumwnF3ZXLQIj7RNSKWkyxL3siU/gPa
    kLvxw5w0xfBWTx7LCQytJiPhH/6TUsijvMSEoNhqzrgL0TLJVEIAxKmfVjH6ppJP
    JaOV26UiUFyexGTOC28pme2H9ed/VQJzbCe7aiV0pt85hswAV21VH/L2dJF0XrP+
    MYStE8rmbIZttPjOfTNM+uPtnc0ThJNmPll6OS88I9pVNv+oFGuAm/xGzJCLIy7w
    qRN+fAphEajhZsTzKA153lVSkh/956ZN2tqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524057706; bh=iLe4NoH7L+FCytR3iphxVvnUR9PYhK
    379/0xN1mjKbE=; b=wCqK+IlB8YDe6WfCiFBpKKTa6y8QSPBoxcde9OTVO8xtvF
    x90VxdblFGYnumCc+YgSlnRVrndp4KFwD1BLVuRRrs5TxryB3gtFbZQIBSy0AmxJ
    sjKhPCYhkRClXOPHzDvzZBEVNkfm6qEFo6rJhdgrXIXCies4ZIXfxvDvZgcGfr3B
    KHrh1i99aLQ9+zvODUWaQVo5s1kAufLTK/EsoOX87U7uKe1jXjE0LCPPB4hS05Dr
    S4ng7m59qXdrdWY5pGr9LoBAtXsWRyRuefe+qGKD8G0d+exOA++BtunMOApjq7SO
    dcgAz7S7AEaeILYplKrDa8/N89N/oSNTeG6fS26g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOwluBSMKnzkNuLXe6yXvb6klDhnTg6R5tcRURURJgVoqGxjgS7gzf76YvCRDt61EoQkHCxhtpd+IPlr+du/TqJgCdmjF81V+QnEZRSL+AtcGd+oTFv3
    N1ADi22xqqb3mCCAsFjyZKhLDswL2paiHm3j42r1J54Jg7i/aRcPfzoApmVeK3Sk9dWCB6MopYUEzjYsJZJr2C0KM6XhXCWfnPa8L7gaE7UakXpSmaRhHAEZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8 a=3zr9wtxuqwy6ALpDAkEA:9
    a=jxM0K1Dsy3mRDvoC:21 a=8IiHLW-dyQnudiZ7:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeDRNVp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 09:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752617AbeDRNVo (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 09:21:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D28C2077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Wed, 18 Apr 2018 15:21:38 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        peterz@infradead.org, acme@kernel.org, me@tobin.cc,
        keescook@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] module: Fix display of wrong  module .text address
Message-ID: <20180418132138.4xzgnwi6k3uojghv@redbean>
References: <20180418071436.21392-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180418071436.21392-1-tmricht@linux.ibm.com>
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+++ Thomas Richter [18/04/18 09:14 +0200]:
>Reading file /proc/modules shows the correct address:
>[root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
>qeth_l2 94208 1 - Live 0x000003ff80401000
>
>and reading file /sys/module/qeth_l2/sections/.text
>[root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
>0x0000000018ea8363
>displays a random address.
>
>This breaks the perf tool which uses this address on s390
>to calculate start of .text section in memory.
>
>Fix this by printing the correct (unhashed) address.
>
>Thanks to Jessica Yu for helping on this.
>
>Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
>Cc: <stable@vger.kernel.org> # v4.15+
>Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>Cc: Jessica Yu <jeyu@kernel.org>

Thanks for turning this into a real patch. Looks good to me, if Linus
wants to take it directly:

Acked-by: Jessica Yu <jeyu@kernel.org>

Otherwise I can take this up my tree.

As Linus mentioned, we should technically be checking the opening
task's credentials/capabilities, but converting everything to pass the
actual struct seq_file/file to the sysfs show handlers would be fairly
painful :/ At least those /sys/module/*/sections/ files are all set to
0400. I think this fix is sufficient for now.

>---
> kernel/module.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index a6e43a5806a1..40b42000bd80 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1472,7 +1472,8 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
> {
> 	struct module_sect_attr *sattr =
> 		container_of(mattr, struct module_sect_attr, mattr);
>-	return sprintf(buf, "0x%pK\n", (void *)sattr->address);
>+	return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
>+		       (void *)sattr->address : NULL);
> }
>
> static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
>-- 
>2.14.3
>
