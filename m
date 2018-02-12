Return-Path: <kernel-hardening-return-11718-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226nBRvfjVZE52IqXGvgPmxY5sHzmqfiBqgLE8WA2ApGkXGS49fZ4rzU7+g5dsHQs1b1UiB5
ARC-Seal: i=1; a=rsa-sha256; t=1518440073; cv=none;
        d=google.com; s=arc-20160816;
        b=W1T6pvECz4Ca4kfJ4Wme9h+DKskfoAiQunyT8zLL8wd2AgwZPe7VujYVazE5Br80oa
         xjDe/HkimM9I/RYuWtb497LNXtqPpa5omUu7M90zxtn7nykS0cEdDdahOi5nmrZvvzVP
         5btt8goXhGEnY4B4aeDYhRmewke7wZntTgCy/OmykvVEAEbcK/eWDveUMNk0ixRBqT5q
         QhFeTLIQLseEPtDizILOu9Lt6pJYuCGH98c+5berobCuLpmYWL59AdsA592COHCRLhqL
         ERocZ7fQmPQ0UmFDP+lhDnHCscYR+cBfbsxczwdT800A65UbC1NMVLwwff1tTwaWpR9j
         gfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:user-agent:in-reply-to:content-disposition:mime-version
         :references:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=UDcmFcOP2xKLBFtazfVBEXUfWq5osKJaQYZgn2kBXD8=;
        b=0D+BEef5OT6A20ez0BvfUFWNv8RXjlHzarWP9/N/ISHX+NyYUWZbqE1nogCT3OJZ3k
         y1IQR6KQ3Gq1g5nm1d29/GL6u+4OJ4AtDjfKslMQrTF17WdQKxz1vd1iDFiq0HxySg8v
         3kVjZJHlhc81cW1O/vjzQBm3cdr0Q2PNL7gNTGdvtigmY1+hMR0vbXaDUaFjHKBbyL42
         pH6vEMsRQ0heFMzLLRkEgaIsjUm7sz1BakAqUrDpNPdDOaH6jFQrtQkXlZNiqoeMMxKL
         apo1Ja2T2RCMLi9OAyZLZ+nZ2MokpMR0R0kQ2r08tvrGI3NMX1hzagyBJ/+jNNoH2ajW
         Vhig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11718-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11718-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11718-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11718-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Feb 2018 14:53:47 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: willy@infradead.org, rdunlap@infradead.org, corbet@lwn.net,
        keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
        jglisse@redhat.com, hch@infradead.org, cl@linux.com,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 4/6] Protectable Memory
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-5-igor.stoppa@huawei.com>
 <20180211123743.GC13931@rapoport-lnx>
 <e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
 <20180212114310.GD20737@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212114310.GD20737@rapoport-lnx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18021212-0040-0000-0000-0000042EE5D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021212-0041-0000-0000-000020D2A591
Message-Id: <20180212125347.GE20737@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120167
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592199819002651571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 01:43:11PM +0200, Mike Rapoport wrote:
> On Mon, Feb 12, 2018 at 01:26:28PM +0200, Igor Stoppa wrote:
> > On 11/02/18 14:37, Mike Rapoport wrote:
> > > On Sun, Feb 11, 2018 at 05:19:18AM +0200, Igor Stoppa wrote:
> > 
> > >> + * Return: 0 if the object does not belong to pmalloc, 1 if it belongs to
> > >> + * pmalloc, -1 if it partially overlaps pmalloc meory, but incorectly.
> > > 
> > > typo:                                            ^ memory
> > 
> > thanks :-(
> > 
> > [...]
> > 
> > >> +/**
> > >> + * When the sysfs is ready to receive registrations, connect all the
> > >> + * pools previously created. Also enable further pools to be connected
> > >> + * right away.
> > >> + */
> > > 
> > > This does not seem as kernel-doc comment. Please either remove the second *
> > > from the opening comment mark or reformat the comment.
> > 
> > For this too, I thought I had caught them all, but I was wrong ...
> > 
> > I didn't find any mention of automated checking for comments.
> > Is there such tool?
> 
> I don't know if there is a tool. I couldn't find anything in scripts, maybe
> somebody have such tool out of tree.
> 
> For now, I've added mm-api.rst that includes all mm .c files and run 'make
> htmldocs' which spits plenty of warnings and errors.

Actually, you can run 'scripts/kernel-doc -v -none <filename>' to check
comments starting with '/**'. I afraid it won't catch formatted blocks that
start with '/*'
 

-- 
Sincerely yours,
Mike.
