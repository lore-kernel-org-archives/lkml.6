Return-Path: <jikos@kernel.org>
X-Google-Smtp-Source: AG47ELul36OVOlUfichB+ecsjvyV/BWR+2Ds9TwvkZ1OTrCV/hWZWit5UUJOj4M9vVWfiBB5n7mR
ARC-Seal: i=1; a=rsa-sha256; t=1520427360; cv=none;
        d=google.com; s=arc-20160816;
        b=COmxyMfM9swt4FIQZuBnbIekhbSBsc/9Wn7tzqOhYNKPWg8FqDJ2tj5blbkmujRkDQ
         dxHpMqslkdvkvrgOPf8GHDljaA0ysU+7vt6kd9iisu41jIfFeV3+upD1Yyurnra6kogz
         ZCI7TihhqcvR7m7koJqznJNckNulSOuPUzzQjbHT1uSJvFXvhrLSfu8fuY7XviuGlNs4
         w1cXayXAF7mj8zBtorJSKd/QpVcS1xFYSvQ12zTdcdHnUC7YF4GHdqMqsq/Hxzj5Xg8b
         kf/3gXNBsehOIVCWXWpeVPGONDgOeZgPaDOdhzgEPNLbV17oscdkZ56cjF5SqnhHwuKv
         6BiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=ruPo9rb2dqzppwJ33qldby/DzD1i/lagvaGJ6GBGXP8=;
        b=GcT42j7g19cw5zgdGxxY/+b14a483IuEQ3XhJjPYv96Pa7ZLN0//K8J1152FdvZfK2
         4KOVF0cVIbD1NXVpAHviRW5CSUT4dc35b3RggpIZblew6zPPiKZr7jofJZXWXpUtS+UF
         nDUjcTFsOO9X/SA7/+heIVZuZWqisAbXsWHR/+YQFfohrjfCdcWupz1MFZeHIso38fBZ
         kdphp9oLHC4d4WfXO1KFk0DuyHxxsnWY/Q7YkcU3hOpKlWD7BIEspG9yooZIZhVUbpV4
         hRzLht2y4v+RYDZvhGqmX9jt3Oem1OvTbMi2XHO5luQEmg1AyAhMRZnK7Wvc+BQKIauM
         N+7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 91.219.245.39 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 91.219.245.39 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Date: Wed, 7 Mar 2018 13:55:53 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        Corey Minyard <cminyard@mvista.com>, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 4.1 00/65] page table isolation for stable 4.1
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
Message-ID: <alpine.LRH.2.00.1803071349120.22688@gjva.wvxbf.pm>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145857486900392?=
X-GMAIL-MSGID: =?utf-8?q?1594283640046005254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


[ adding Hugh and Miroslav to CC ]

On Mon, 5 Mar 2018, Pavel Tatashin wrote:

> The git of this backport can be found here:
> git clone --branch pti_v4.1.49 https://github.com/soleen/linux
> 
> The patches were backported from stable 4.4 to Oracle UEK4.1, and from
> UEK4.1 to Stable 4.1

You'd want to consider also taking trampoline stack entry patches we 
currently are putting into SLE12-SP[23] kernel tree [1], which also bases 
on the original Hugh's 4.4 port.

I've notified Greg already that trampoline stack entry should be put into 
4.4-stable proper as well, but that hasn't happened yet.

[1] you can find those on https://kernel.suse.com/; the patches that are 
    currently in (commits 6d3ee9dc14bafff and f7de61af517916 in 
    kernel-source.git there) do pass the usual battery of PTI testing.
    There will be some changes made to it to avoid external module ABI
    breakage, but those will not be picked up by stable I guess, and you
    probably don't care either.

-- 
Jiri Kosina
SUSE Labs
