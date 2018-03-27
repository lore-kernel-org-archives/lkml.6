Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2952182-1522132156-2-16957522419514168875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522132153; b=pNmJ/lbWFatwyQZl17FmrT3Nk7NDJIBgVtNF5tJTEsUK4HQ
    /6vqyRRYVMyob7DhE4fwCSZq839esut3s7B2BMB8BjOgbXsknyZ4QRQ/vt35osSC
    kDiY4R0MrOXA95PUvmq2quPve3IafjX++zGa8xeayeGJIF+6vmcla7RHxjqs5HXZ
    3M/i2OjCbX3YRgS4Fdlu9U0OJqrujkdY0jb7NPlst6l1pd8H7SMrcRDq2XT+RiK/
    EVYwJQSm38HGdwRYf2KPpj1xqMV08hc+beR/DNOCbZladmeACGV6v2pHok8vcw8X
    6Ur4pejiA7der1OYO28qCyqO31MUYv0znCP0hwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522132153; bh=L
    ZwcKXRIBiYZ1bBK9Y3qEhCj5wIVyraCLJEmhnWPGa0=; b=MMqEsnVLQtU/T1PP7
    Rp/n21C2qx5IWw432+ke+//Ycy1OEkj66brtL0OhfLcVH8RJftf9mmkncQDqLEF5
    NBc6B/ARJTLbzgQ1nEYFpuFKvQoReeMWIFQdUl3wN2DD97dyets2uYmQu8jFIs0J
    PgAlgF7CyLmxCmDOvOQAP8uCGlag0v8Imd2VFyyU7qOY20FySDMMNfEO94kslbWG
    k2LOZowWuVQUo3ieZ7Av2cuboDO+iJ6pk0Nee/Xq0WYFctbkRR/rnWLxwDxLOuBV
    B2bGrdGDG+2tRHN+IQYhV9qUveCVhnl6Y6A5L1/vNpcdy6f1nswQwc59us/nknEt
    4Emiw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKXVRLYRNoSm7hzG0opNMCt7EA+LbpzWounDmZq0SNexFPO7phqUGvMRTGE778OVU5r3dwXOPodVVNe4UQt0nIWNtg4RRirb/rKH1jEylYJK5Oo5+5W2
    66OWX2ipenYXKnZfjelU8cOITQFWs9wE4XutQ4IJyjG2vUlkg94kU6Rt3azJ2SJC8cKh994TPX2tePaDO10mT1qsSIyyRHpgWS0zChM5nkwMiX50DcjvAnRx
    R3PJMHRmgIOhkAhi2ZcQ4Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=qYrKbu7sAINvDlfnI6wA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 27 Mar 2018 08:29:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] staging: media: davinci_vpfe: add error handling
 on kmalloc failure
Message-ID: <20180327062904.GA29640@kroah.com>
References: <CGME20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2@epcas1p3.samsung.com>
 <1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
 <20180327050045.GA12754@ubuntu>
 <20180327052058.xphi47mnnbtjl2fc@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180327052058.xphi47mnnbtjl2fc@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ji-Hun Kim <ji_hun.kim@samsung.com>,
 arvind.yadav.cs@gmail.com, mchehab@kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 08:20:59AM +0300, Dan Carpenter wrote:
> On Tue, Mar 27, 2018 at 02:00:45PM +0900, Ji-Hun Kim wrote:
> > 
> > Are there any opinions? I'd like to know how this patch is going.
> > 
> 
> 
> Looks good.  Thanks!
> 
> Greg just hasn't gotten to it yet.

Greg does not take drivers/staging/media/* patches :)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
