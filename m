Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1673992-1521823644-2-9661815234666625194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521823644; b=u9xZBM43ObsDx9pEHfA4DOp8CNfteEc6Ubpk/rKIcq4dugb
    cKHi1aKcMsxTcAI3s0P2hREKyDoWsmggoAGdoa7WHQT+XpcqffDT+hl+fS1izu/o
    3VSVsM1u9DNtOQcAl9XZYAFREdQ5m5SI2xRLGuZ79BsGC+aa7UQ2XYqD5nXoPQvw
    y67o1Xo1D5qvsmOPlhKAJaWMj+WA8Tgh3EGD9+aj6BkbT6LPAbhSJuJn20Ip8Nf9
    FxxF1Iv7Ak+UNoQ6JPWtaYx3MO23Nl+l79sXX2sFz2WhwI1r3fpbtNaky2Ymuexr
    5mpGmYGd+RmBNqWs23iRdr4ENDjb7T+OnRf0Cdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521823644; bh=j
    +vt8IR4x6hHdKVD4inU+LlLL7raZvkNWirIfLSmP/Q=; b=wvndvHj6egjZw14XC
    rnJO/3Cs1nKyhoeC+mtHTru2ke2JXSEYW4Q6J/ZFvR4GUiz+YFsGplWe/1tAnypt
    AfYGhgwhIl3PgTeysFxYCbpSIP2Kw+Pi+5i3xujgBrdyAKMeNr1LfTVX1BQxBMrB
    GsGS2PTQ92E77EmKYvcCrHfN280/q1vepkbtUpfgDeWyHPVwDAL/bI5Ku+sP1pbb
    YxUJ1VuA25kY07fA7aax46yBTabZ3GChZhw1X84KNnH88Ju28+KbpTl+D66Vumle
    FDncppdERUfrTPgETmeltzVGVnr9P21ZZdIPm3vv9lLQYxxv2XNqnxRVyKlRoD08
    FKg9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 17:47:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180323164716.GA7794@kroah.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321162555.GA16028@red-moon>
 <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 04:41:02PM +0000, Sridhar Pitchai wrote:
>     Please read the link I sent you in relation to email formatting.
>     
>     Then add your description above in a way that anyone not 100% familiar
>     with hyperv can understand it - that's what the commit log is for.
>     
>     You are sending this patch to stable kernels, patch above has been in
>     the kernel from v4.14. The patch you are fixing since v4.11, you ought
>     to be careful since you do not want to have broken kernel versions owing
>     to stable patches mismatches, that's why I asked and I will ask again,
>     are you sure you won't trigger a regression by sending this fix to
>     stable ?
>     
>     I assume the bond driver mechanism is now done and dusted.
>     
> That is correct. I have sent a v4 version of the patch. I am sending this
> patch for stable kernel. We have tested and I am sure this should not trigger
> regression by sending this fix to stable.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
