Return-Path: <kernel-hardening-return-11721-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224orMlSEVWyotz+DGgmnZLt22eD3kYa12ZOIGIzGRYS967OF1iNgjqwkjlTSdzQfnuUreo8
ARC-Seal: i=1; a=rsa-sha256; t=1518449546; cv=none;
        d=google.com; s=arc-20160816;
        b=hq15RptrDpXN/33bm0u8KboZEMfiv7y3ONy01MuRm80h2SdrG4H18Qi/d8j27wcn/i
         RuYgMjqZSDz1lDK/7rti6W8gOXL66FGMuKemcsQumOMn1IxbUtjkrsw4s9lfPFo98nPK
         h4HUEHPjUcs5X6YWzEUfsRfTKopDP0UXPC9TmahKy+b/ZXi3Icsl8NaNtO71RJ8YwxlU
         n7VwLxa+zCiasahYqBbmp6GvulSVeSUeqp3YEUTIERfZwpPEn8/BntoJdBAAzRXDp0Wg
         AgdD6B6rIPozOR6FONck/jCMdOIHFnl+vaRBfCHhovZWSeFp6mCofPW3674Ps6Jg4Vg1
         IyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:user-agent:in-reply-to:content-disposition:mime-version
         :references:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=j+1qFqv5OpZOPde7czQGfgCtzHy5sl7lKugYLzcE2f4=;
        b=cFOd6Pf7GK92LlVpiOmsnLQ3FH8IvH3EYcUtHA8jL5SQOlJOHtKpcbcb2oW4duygxa
         68FYMmuBIR+NjdSSjkGQfQQpgDjXXT+GeCoAcZ4vcPYF4IjWMHZmsv/0F52ulD5JYHpf
         lyuIGHkEVoUILYRp/23AqKgk0pmIKb13+vj3esPhMU69U47R9X99oPEbpADYgMe8bOVg
         eTJ4+A6S8sTL+DcpS1xwQG6IC/iYL1ONUycVR8lIlNTpvmqkQvvMzhBAxfw+XMhJHNDo
         gVm8zRG4XHcOHucMG38+3GPt5vBt8qjYO7+3qMIXFhe1QaPBJtJ9jvT+8xGuc0VdpGUG
         MazQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11721-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11721-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11721-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11721-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Feb 2018 17:31:57 +0200
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
 <20180212125347.GE20737@rapoport-lnx>
 <68edadf0-2b23-eaeb-17de-884032f0b906@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68edadf0-2b23-eaeb-17de-884032f0b906@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18021215-0020-0000-0000-000003F4D9C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021215-0021-0000-0000-000042876228
Message-Id: <20180212153156.GF20737@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120199
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592209752294587810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 03:41:57PM +0200, Igor Stoppa wrote:
> 
> 
> On 12/02/18 14:53, Mike Rapoport wrote:
> > 'scripts/kernel-doc -v -none 
> 
> That has a quite interesting behavior.
> 
> I run it on genalloc.c while I am in the process of adding the brackets
> to the function names in the kernel-doc description.
> 
> The brackets confuse the script and it fails to output the name of the
> function in the log:
> 
> lib/genalloc.c:123: info: Scanning doc for get_bitmap_entry
> lib/genalloc.c:139: info: Scanning doc for
> lib/genalloc.c:152: info: Scanning doc for
> lib/genalloc.c:164: info: Scanning doc for

 
> 
> The first function does not have the brackets.
> The others do. So what should I do with the missing brackets?
> Add them, according to the kernel docs, or leave them out?

Seems that kernel-doc does not consider () as a valid match for the
identifier :)
 
Can you please check with the below patch?

> I'd lean toward adding them.
> 
> --
> igor
 
-- 
Sincerely yours,
Mike.

>From 35255bc2d7d2a63be4f78a7bf4eec83ab0dc4f3f Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 17:19:04 +0200
Subject: [PATCH] scripts: kernel_doc: fixup reporting of function identifiers

When function description includes brackets after the function name as
suggested by Documentation/doc-guide/kernel-doc, the kernel-doc script
omits the function name from "Scanning doc for" report.
Extending match for identifier name with optional brackets fixes this
issue.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index fee8952037b1..a6a9a8ef116c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1873,7 +1873,7 @@ sub process_file($) {
 	    }
 	    elsif (/$doc_decl/o) {
 		$identifier = $1;
-		if (/\s*([\w\s]+?)\s*-/) {
+		if (/\s*([\w\s]+?)(\(\))?\s*-/) {
 		    $identifier = $1;
 		}
 
-- 
2.7.4
