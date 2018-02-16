Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-647902-1518803136-2-5001577737794407976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518803136; b=efeVfOqwm9nmG1U4neAqHrRJpxZmv2mWg+oBNnpcyqd29rg
    00rqftxo7Yq+pLIcCd/WuOY9Z4O1X1/LzeOvFzTYTRHhnK45QLRqvxvkGczxOQc3
    c9V/Olkm2R3UAhb9M52rJEtM5ToSlnMyNek/2+cl1v+sCciORelueAWk4XiX27KD
    j2QX0xCfegwXcCGU1LSJKVLRobBeaRugI7Hb1UyROuHrdw+/Xz2/tDMeNABEuypP
    4JxgclSIusiazYBK6KSFupqVn9phdhGcHXiBSsnIpVhvLzxq9JE8KZdCGQm+T8L2
    I+mp27DsQDN1IdmTBqAZaBFN6JklQqcdYwoKhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518803136; bh=d
    cTEOLeXNKEZGw2Jl+Vkm9sxyaGLT7e001WZOm25RtU=; b=p4uFYhZILKaDvoOUA
    mUF9CyH54FH8COT41geLzgY6QTAsqHj9z9lYv/iiAn6+EeG2d87o4ITBItaIIV6Z
    qqeaOOoPtjEM5yGROfDiPndWLBJJ1XgVVit1W+QUdvYXGSiSY4izaRCFWxvSDEn0
    BwBx9xlrXRAjw9G3S1P1ht7+srvcvBUkuUFqR+c08bOjj+x9yeRJ+Fft6tGHgZX+
    M1Ux+vcojIU2lOgkbvUblWHuuc2wmk2vbIwgmyFsFCen6L4V0s5j7KfLjee0bQPk
    cZHjyiU+Qf1Nc3RYufpV7vrEmBHh+2UB6jRN3uadk/eIbYGWw7GmG5zp1YioR+4f
    /GzUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=JmS4RTbk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Qdab+Ibj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=JmS4RTbk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Qdab+Ibj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53E3F60817
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Fri, 16 Feb 2018 09:45:28 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
In-Reply-To: <9aa626cf-c122-55af-0c95-a9e9c12c6f19@redhat.com>
Message-ID: <alpine.DEB.2.02.1802160945020.20374@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
 <20180212065620.iqlzczhqzlrmel5n@mwanda>
 <alpine.DEB.2.02.1802121319370.2345@lmark-linux.qualcomm.com>
 <9aa626cf-c122-55af-0c95-a9e9c12c6f19@redhat.com>
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
 Sumit Semwal <sumit.semwal@linaro.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Feb 2018, Laura Abbott wrote:

> On 02/12/2018 01:25 PM, Liam Mark wrote:
> > 
> > On Mon, 12 Feb 2018, Dan Carpenter wrote:
> > 
> > > On Fri, Feb 09, 2018 at 10:16:56PM -0800, Liam Mark wrote:
> > > > Fix the dup_sg_table function to initialize the dma_address of the new
> > > > sg list entries instead of the source dma_address entries.
> > > > 
> > > > Fixes: 17fd283f3870 ("staging: android: ion: Duplicate sg_table")
> > > > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> > > 
> > > How did you find this bug?  What are the user visible effects of this
> > > bug?  I'm probably going to ask you to send a v2 patch with a new
> > > changelog depending on the answers to these questions.
> > 
> > I noticed the bug when reading through the code, I haven?t seen any
> > visible effects of this bug.
> > 
> >  From looking at the code I don?t see any obvious ways that this bug
> would
> > introduce any issues with the current code base.
> > 
> > Liam
> > 
> 
> Given the way we duplicate the sg_list this should be harmless but you
> are right it's cleaner if we initialize the new list. You can add my
> Ack when you update with a new change log clarifying this.
> 
> Thanks,
> Laura
> 

Will do.

Thanks,
Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
