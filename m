Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1451110-1526533639-2-5424258434621700308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526533638; b=N64cQjH06iChRXAFREBYVfcK/7XCqMkPBu3GKg0GKl+8rhQAxg
    jsuugvgW70lo+AJDYXb+EqqotXBtitd3s1p4N2uTNZpdEb8dUNEdnuXRX6+XBUY6
    dSvI6yh/6zaNs78z9KpzQ2HTFKR9E1p2TmFtcBIFe47Pm1Rsqgo5nL+RBr7sTkOl
    eAjp1DYpKY7fTI4nnIGWd21/KH8XdnwNB/5gIjUgn+45C5YWljXjG9dAbrpVOrbt
    wWDATi9bivyoR8BO/fuTLtIdqh97TEsLKOq038NC5oG2hFOzm5II8zGEXdnXCaQl
    K+GuK2uPg3Ia7p7G1qdZ9TjBe0F+Po3aeA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526533638; bh=JBFOt
    8ciRAv27XrRqnWurUfPlORF854XiRhC9oQxSgo=; b=MSn/DogwpU/ck9/4NfR7j
    sNzCuT2kFcq5BgZ2g7CaHacFmYT+baqdft2eAs2sBUvgJb9e0Wzyvm4vTEV3duIZ
    aKQQtXQKIv4QckHwz2yrDefj9qkop92O6F918GkyUTdmEmG7nJ6g2sSB1ApACzmW
    d+XCR0kYq/93HeVqmS4w9M9jaR9zMolIoGWcryYPGnd8o2HEe7/ckTibGFTEXgmF
    GzIXX1m0xvKpg2ARCCPIuU+c8mBVX3N9rHw2CWPhkWw/VAt525quS+vML+GgYx2C
    2zwwtE8To5QGIzSMtliHScAIQHu+BUrbTWU7kQR+cZLJVSW8V16mT+kO7J7je30c
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=jDJEvQIx
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=jDJEvQIx
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDKO+ew8hDSOK4oGjIqB/izr5FwxVAiLFNKiwUqPinCA7l2/TZWPz5kTxlknVJZKfu4BdWyocnGRjvIOnauy6GhrRS6RU4RfY7E842OsF4T/IcGOX1Dt
    5VNEswDAlexK3zp2S3L8ZvMXAfg0+ziZHY1Jpzay+vcvmyQoRncVq74RmBa4QKK99Cl38+irCdPUT1pBMCwuqGyNkA27clx7KwRfPzc0KbZkzCzqajy1HWGK
    ReArXA/W3v01WV9Rx1s/bw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=eHPOHxaFGdUwg9Y_0UkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Thu, 17 May 2018 06:07:00 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
In-Reply-To: <20180516165719.GA28434@kroah.com>
Message-ID: <alpine.LFD.2.21.1805161931400.17395@casper.infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <20180508114500.qrtnjax4siupgv3n@mwanda>
 <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
 <20180516165719.GA28434@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180517_060700_857423_89D329D5 
X-CRM114-Status: GOOD (  25.95  )
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> > > Anyway, I understand that Intel has been ignoring kernel.org instead of
> > > sending forwarding their patches properly so you're doing a difficult
> > > and thankless job...  Thanks for that.  I'm sure it's frustrating to
> > > look at these patches for you as well.
> > 
> > Thank you for the complement. Also thank you for taking time to review
> > these patches. Your feedback is most welcomed and benefitical to the
> > health of the lustre client.
> > 
> > Sadly its not just Intel but other vendors that don't directly contribute
> > to the linux lustre client. I have spoke to the vendors about contributing 
> > and they all say the same thing. No working with drivers in the staging 
> > tree. Sadly all the parties involved are very interested in the success 
> > of the lustre client. No one has ever told me directly why they don't get
> > involved but I suspect it has to deal with 2 reasons. One is that staging
> > drivers are not normally enabled by distributions so their clients 
> > normally will never deal with the staging lustre client. Secondly vendors
> > just lack the man power to contribute in a meanful way.
> 
> If staging is hurting you, why is it in staging at all?  Why not just
> drop it, go off and spend a few months to clean up all the issues in
> your own tree (with none of those pesky requirements of easy-to-review
> patches) and then submit a "clean" filesystem for inclusion in the
> "real" part of the kernel tree?
> 
> It doesn't sound like anyone is actually using this code in the tree
> as-is, so why even keep it here?

I never said being in staging is hurting the progression of Lustre. In 
fact it is the exact opposite otherwise I wouldn't be active in this work.
What I was pointing out to Dan was that many vendors are reluctant to 
partcipate in broader open source development of this type.

The whole point of this is to evolve Lustre into a proper open source 
project not dependent on vendors for survival. Several years ago Lustre 
changed hands several times and the HPC community was worried about its
survival. Various institutions band togther to raise the resources to 
keep it alive. Over time Lustre has been migrating to a more open source 
community effort. An awesome example is the work the University of Indiana 
did for the sptlrpc layer. Now we see efforts expanding into the realm of 
the linux lustre client. Actually HPC sites that are community members are 
testing and running the linux client. In spite of the lack of vendor 
involvement the linux lustre client is making excellent progress. How 
often do you see style patches anymore? The headers are properly split
between userspace UAPI headers and kernel space. One of the major barriers
to leave staging was the the lack of a strong presence to continue moving
the lustre client forward. That is no longer the case. The finish line is
in view.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
