Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-923319-1524475105-3-15068131822519155845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524475104; b=cRsFyfQze2hM+uyeDxeLAZF2SaBmcJnedrgZ102w4MyQJsfrPY
    3J6gteY63iXlgXrbZGCtcujgGq24iKbHq8UIyIBkc+A3UoVux5E4/xRkh/Np4nm7
    y/0/B7+59NtPm5UhIjxrPej3gPN2pFIlyVmXXvaSt9EKYoWSqG1Bg8z8Rn5CVBuG
    J/oCfkdc2zTszvrsU5HBMCA2DgK+BrDKIYx6+iytk1mWKFDpvw8OiMYnw3rFPI5d
    f/eiGp/ujiTNkrxiNxXgzRfQkr6cJQfeKPM5wuid+D139izH527PoBWC7ETzC8NU
    FqZjpOy0DSLQ2P/RnoU2zOHHrPIXbEv6fWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524475104; bh=HjuKJ
    x9Za0CRms0NQ0MYb9U7emSTzMLc5/GJacpzea8=; b=vklpbXdyZ+zHd8AiC+tGS
    c4D4Jflg9o6mYN1C7ekveH1a2tZj7TCCB2cskszAUGSLHMtLm8RpxiBQE+LUwQpc
    pkKL+0raKftZ5W2ortA4DiQLhy02si+fBItZKW0ymMrj4N8Cd6tkGD+lPGrEu5Mq
    KDwuwSHspfeNOQhGG5CgIXzsGM0tQ6S9Qr+J+x+x9eafd325NogWxoo01pte+Igs
    vKbsPpeic35Lbm/uDP+HLgwyWOFBOm0/SiGW7hb5m3f9v+WSIBziOB8DzxtQszjc
    QdURVPoolD8OKmsA3dvJ++JhzJrwJ6Yw7mr6FmeffmmJuQHmrwzkliNS71vXTWv4
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNW6vPbVIpTPodSY15j2U2fq1g+lu6DZ209301Nfzq0r1O/xPnGuJb8uGhsaC7bXMR6c2smElE9W12VxPtIEiC/zqGoq6pJ+9MuTY+ksMmNYAAAanx1
    /wShZQbuAz6Bk48gz5diGbPthR1aXRZFnCbJ0icdrwccJwm6HcMrRV+0qVymqYItPzvL0F8y11MNmJJkeHw9rHUD1wdTUXyeLKpj/Tw5acwHjyQ/QzsTtRlW
    j8x540pgfL2j6k8+K3TxqQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=sPEKT-_OGD64R-LmTNUA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 11:18:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] android: binder: Change return type to vm_fault_t
Message-ID: <20180423091812.GB14322@kroah.com>
References: <20180416151121.GA26791@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180416151121.GA26791@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, tkjos@android.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, arve@android.com, maco@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 08:41:21PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler
> in struct vm_operations_struct. For now, this is
> just documenting that the function returns a 
> VM_FAULT value rather than an errno.  Once all
> instances are converted, vm_fault_t will become
> a distinct type.
> 
> Reference commit id->
> 1c8f422059ae5da07db7406ab916203f9417e396

As you know, that is not how you reference git commit ids.  Please fix
up and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
