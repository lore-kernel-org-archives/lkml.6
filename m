Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2316417-1518470762-2-14057601458195312010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518470762; b=ts9WgLgFuLVm5Vp3Bd6iq2i3PieE+Ln1PaGbNbpi4vTRXax
    QDvjs/oBOySC8HqPizVZmLkwFqPsfgUDyAHp/q6nNnzF9GRCuB6D//PyPvRoAZy1
    AVhRoP2BIFhX8b6W684VzFIW2A6ugLN7nfVCaTZ3KJd1gmb/fXwRgfJLtRCK/KdC
    XqhMwV8WdCuxJwsZ794lialJWjeBbKneswuGyqnZRmCzWLLBm4jW4sqXvS1LpRdB
    VB2YgE2IKG2CwtN9+7uUCRuveh+ZtUK9Fe1/T4yMeM/EWTLDTCyTFbIR+2O3YXs7
    V0t685Z43aCxtJWsc3hDcZ/6A4bpcjPXoAYF3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:content-type:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=arctest; t=1518470762; bh=RTTpG3YnU
    jt8lQzHKnoC98yDqttHQRatBqlw4APuFK8=; b=CiXjxA5O8LsBcyLErDndSGOCD
    uVhBub08WwM3vUnDboQqdwvpXaKXyhBZkCiu1mZGwCQ0O8wmNkaDsfyVie4dF7Q1
    L4qmITsp9SAYv0OSEF9nYZiY6PptBJbYYzNbrHVVLgm/FOj1gZhOlgSOcmzGymf9
    4t3pQGZE5J5RIbiANvSxrlI60WUKJbwsxUmmxiKGIpgTKMxc4pS/akY9GtvoAp4H
    SL31d/JtpweEaG5F5cABQl4lamHIotHXops506H7T6CGrABsmzvz8ulHq66gpjMJ
    /waFXeAOLEjzIVosPmzSfFNhhJnhQleY4ENOrBOtLj79+SMz+ikevMe7jmbXg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=jaZ5CUNN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=jaZ5CUNN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=jaZ5CUNN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=jaZ5CUNN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31F59607C7
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Mon, 12 Feb 2018 13:25:53 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: android: ion: Initialize dma_address of new sg
 list
In-Reply-To: <20180212065620.iqlzczhqzlrmel5n@mwanda>
Message-ID: <alpine.DEB.2.02.1802121319370.2345@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802092203150.2846@lmark-linux.qualcomm.com>
 <20180212065620.iqlzczhqzlrmel5n@mwanda>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="-2046127808-1346162756-1518470754=:2345"
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
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2046127808-1346162756-1518470754=:2345
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


On Mon, 12 Feb 2018, Dan Carpenter wrote:

> On Fri, Feb 09, 2018 at 10:16:56PM -0800, Liam Mark wrote:
> > Fix the dup_sg_table function to initialize the dma_address of the new
> > sg list entries instead of the source dma_address entries.
> > 
> > Fixes: 17fd283f3870 ("staging: android: ion: Duplicate sg_table")
> > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> 
> How did you find this bug?  What are the user visible effects of this
> bug?  I'm probably going to ask you to send a v2 patch with a new
> changelog depending on the answers to these questions.

I noticed the bug when reading through the code, I haven¢t seen any 
visible effects of this bug.

>From looking at the code I don¢t see any obvious ways that this bug would 
introduce any issues with the current code base.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
---2046127808-1346162756-1518470754=:2345
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

---2046127808-1346162756-1518470754=:2345--
