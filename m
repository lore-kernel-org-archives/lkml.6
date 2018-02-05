Return-Path: <kernel-hardening-return-11588-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224uQGe1U9my5oVVU1ek/1e/oRvvY+FGmNEANARJ2a+xBYHcZbB5semcIYXC7rES9AOwbBVD
ARC-Seal: i=1; a=rsa-sha256; t=1517844818; cv=none;
        d=google.com; s=arc-20160816;
        b=lSZwWxL5IkiY/wCiFNYrVCf78KoNyfcJ6sPIvojkJwkhRAxhvYg4bUl7DMdUXzkcQn
         Ll7Qvew80rIhfF3FHRDo71tVGClAFs9hZ+1llGxll5c+uG+pdHbgHJaAxTXsqx/dmUUS
         I3iuRSQetfluhB5KWBloGiU1e9oN38q6KADO5xSz511BNkB4rhXuo0a6cg+Z7Q/qynT/
         uhImIBYG5YYESqmN6wobzOQ8spB5mGipWda7ULAibvgO+Ux5obd1MT/zkbLcuSWNh29u
         FHBTmX84vQZ3hEFhUcULSC4hibPvGxx4n7XesNcfGdYXdCpRAKCC0Z4pidzr3oCsZvwN
         iOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=mzQlAY2G7F9aU4iiTCO6WgjBTpMdYzHruZgW9l6dq4o=;
        b=xF03ExVAFpXdrm7LLzrQbcMyi+LMar0/FPidXqJMEf1+ux0RbuuV10WgLBtI2nuD+c
         iRFv6GG1aCSOizK8OJkiakNyc4SiYMK2PurqLnbad9rBkHwaHzQA1oCagf3J4I8xHpdv
         Utbnmswcv5Ubl8U2A521F6Du3OYJzHumoefwWHHXnJ6vXW+MDRcZ1zqz/F1IF9sFgyY4
         5ocDHxZVwkN711B8Tvt0G9crGE7BhufWcNwY6yLzH55AB1nnyolwuHnTxmGOxFCgzjhP
         OZBYp4sO61Iqr9zC4QGq1ZyJDi1x8MpohAh/nixkfrKe4becFkhoHBC+Hs5XijZeC0hT
         XN9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11588-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11588-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11588-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11588-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 5 Feb 2018 09:33:15 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Igor Stoppa <igor.stoppa@huawei.com>
cc: jglisse@redhat.com, keescook@chromium.org, mhocko@kernel.org,
    labbott@redhat.com, hch@infradead.org, willy@infradead.org,
    linux-security-module@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
In-Reply-To: <a12afe9b-79cf-d5c1-3795-89fbf61c6c9d@huawei.com>
Message-ID: <alpine.DEB.2.20.1802050931190.10647@nuc-kabylake>
References: <20180130151446.24698-1-igor.stoppa@huawei.com> <20180130151446.24698-4-igor.stoppa@huawei.com> <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake> <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com> <alpine.DEB.2.20.1802021240370.31548@nuc-kabylake>
 <a12afe9b-79cf-d5c1-3795-89fbf61c6c9d@huawei.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfFsg+1P23kR6l++/k/rJ1pGlheiXCgrGRUOwlYLUBBLsN8b5pvofkUt8X63HJbyWieFQB94ttmbcUn2j+bpFO3CDZ/LQsMUqNpLB3r6VN86rQihSVa1Z
 18W3jpsLCQQqZK8sFTmwGOWS/Cxj2corM/u4gqFN0tNGcYIx5gNInAbW10tp+fKebF60pKwJ28auPPPDZBhtUqTY6XB5b5BBo0qDyf8jPtuklDsp3yDeveku
 HHAlIP6uY7bthq0bJFRkiE7lTBizswCgyxENzAJnwnSZANJQJUpBPdg9S/CHOR/bsDLwd1Lw8h5HH6sTWUumAKocpMR4VQNOT/GHVVEhzEN+RXbXZYfN0zhf
 3ijwtrFRPE1EhFgYT08qWb7Q71gY4WW9ECDppAyskVS2jrjzLAT/W2INfJUfdVYAphKB64NimnHwlrYi5toy0EZ3Zhyc7QWjnUKzayw/HotiXw5yUvClFp81
 Ah+jlU+XTmVl7FEmXNCj4VmGpvmxLaAe4IJ1jEuHmzsvK2935YnrkKWtYaI=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591575648706092303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 3 Feb 2018, Igor Stoppa wrote:

> - the property of the compound page will affect the property of all the
> pages in the compound, so when one is write protected, it can generate a
> lot of wasted memory, if there is too much slack (because of the order)
> With vmalloc, I can allocate any number of pages, minimizing the waste.

I thought the intend here is to create a pool where the whole pool becomes
RO?
