Return-Path: <kernel-hardening-return-11750-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224Y6fQsvTFMO8LVpt9xCQ75BaGBqLgCjlFlOBlxc28nlRFmVmfIJew3ykAtjLCpSq5cBLPG
ARC-Seal: i=1; a=rsa-sha256; t=1518558251; cv=none;
        d=google.com; s=arc-20160816;
        b=U1zgNR3S0Qnvhp4u0124pC7ym6gVilSZbaOzfwVasMshdQWS1/pAGKL2ClQq+YKsde
         ew74HjsuCvw4Mr7vdniXAkEkLgMnfTHFoT/qa3JqXJttCuA3iX30IP1S860Msh07gT0z
         Kv99fcMoM3a1P01fr6cLMcoWn8F83DnfwXY7QlFoQcu/PkagpJJmxdAMhob7Dvqdx7hf
         brNOPp1CqUr5mFMh1ad4lqEe6PhJQuoEFbyNXyRNcHUF3S3d/TM2PuBCk9335WF8+Mgt
         WDvyIwLbE0WiHLjjpnqYGJ3tOVjzlymIADkH34N++ye9YtuYj9NEAh9L4lHRKFTFb8Dz
         s3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=1Tbsf05fkeXgek8o5v6BuSpJoDGhlX0bOG6WL7ai/p8=;
        b=09NaESmMb5pielOVUcCXhGq+7Wu8y6btUIFHv/4vmlQ3HBsEOw9eGZfaulDSO3n8nu
         fsLXNCkrlkwEi2wh9rFrDx2wpHz/lbBTVfQQJPpbAeUhb26KCUZ6u3i+/gOQHfi1YNUh
         yfzh754YyzAu95Jyfjz7dnZcCeQLO3pinr2qqllO9hnFVIHDlZihevf7kKylxvZogmtB
         VJhg/G3j5AG+x1QC8F4A7MKk9hVkw8glcs3Fv8YMGmL1N+1zkfSxAmwhv+rCzRhJvVNd
         ZukbJDlnIVAgkv2Q0P9g08y81zGVSl/KSlcdRV/VSi363eN2gpOMSALFt1/jlrf7gRr2
         gONA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fjq80vwx;
       dkim=pass header.i=@chromium.org header.s=google header.b=ffvWa4Cr;
       spf=pass (google.com: domain of kernel-hardening-return-11750-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11750-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=fjq80vwx;
       dkim=pass header.i=@chromium.org header.s=google header.b=ffvWa4Cr;
       spf=pass (google.com: domain of kernel-hardening-return-11750-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11750-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com> <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com> <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com> <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
 <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com> <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 13:43:49 -0800
X-Google-Sender-Auth: Y4ZBlNokbodaOmkdqQ26_HwIOyo
Message-ID: <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Laura Abbott <labbott@redhat.com>
Cc: Jann Horn <jannh@google.com>, Igor Stoppa <igor.stoppa@huawei.com>,
	Boris Lukashev <blukashev@sempervictus.com>, Christopher Lameter <cl@linux.com>,
	Matthew Wilcox <willy@infradead.org>, Jerome Glisse <jglisse@redhat.com>,
	Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592323736342584450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 8:09 AM, Laura Abbott <labbott@redhat.com> wrote:
> No, arm64 doesn't fixup the aliases, mostly because arm64 uses larger
> page sizes which can't be broken down at runtime. CONFIG_PAGE_POISONING
> does use 4K pages which could be adjusted at runtime. So yes, you are
> right we would have physmap exposure on arm64 as well.

Errr, so that means even modules and kernel code are writable via the
arm64 physmap? That seems extraordinarily bad. :(

-Kees

-- 
Kees Cook
Pixel Security
