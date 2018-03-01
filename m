Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AG47ELtvnF9rkcS3UuGKYRzguNDWq3sSCTYXrQgvvrLrdGr0UiQFZlZIPWK/YzlM4j55Woo3R9dD
ARC-Seal: i=1; a=rsa-sha256; t=1519917861; cv=none;
        d=google.com; s=arc-20160816;
        b=NTACZPKT8vsYWyPYet6xxu/jDywwZwNR547QBfZSiSWg90Wgl7kFUXgPmNsz4ofB1F
         C3EXaKYi38kYdViOZUxIdaa/XwFn01ByiWh6xqLKGmA5q6CIu4NbXoOuD6ZnpjTUUae1
         RWWiRl3VSB/5hPZCHLEBz2lMHOMupb54yLT267qXeNRDaohgla7IDBMn2coHLSWBndQb
         OLyGqBxa1qQDOYsYlOKNYIgcuyps17frw7h9Xm5YQ2dbnS77X9mSFpEQrDMmFiTI87Cr
         35IsMEO3HP8NsMPuU5W85jQJ3bh1VCDq31TWFBqH+n1SdRsfVa7vKclqDj+k7ZaWUzCS
         bZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=m2YqKdG5HVEI5gEWYEc4H/F3dAz5yAckbg2SLeMcJd0=;
        b=rWvnt8i0h44xAPNj3LcT8siOmOTKE20GG4CKI8tcdIBQJuwbqgPj5x84c81KIY4Eb/
         UDz9gy2NexlDnjib+j0mLQtdLEluh94L0NkE8bneqcfb2ImwKQyq1uEInBNtoV0A0QWe
         oXdCRT6PxLeyOng5Am/bXPBC29TrgXhkYP4OyAoUlob6axSZuYPw5Sr0/t/rdBvR9Flz
         08BAcoXV+UZGj4FfT8SUGoHXwlJtmUE27Yjaj0NxOl+QLqpDLZ8KKFgIQpp1RWfVl6h3
         5DuziZiPdrR//Zo9ne7B0Nlyr9WP2rF7/gfN8LiyO0kp1mcEoXMBSrqozowax/6eQQGb
         de4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Uw8GxraF;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Uw8GxraF;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 1 Mar 2018 10:23:40 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Maran Wilson <maran.wilson@oracle.com>
Cc: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
        rkrcmar@redhat.com, gregkh@linuxfoundation.org, mchehab@kernel.org,
        hpa@zytor.com, linus.walleij@linaro.org, mingo@redhat.com,
        rdunlap@infradead.org, luto@kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
        kirill.shutemov@linux.intel.com
Subject: Re: [Xen-devel] [RFC PATCH v4 6/7] xen/pvh: Add memory map pointer
 to hvm_start_info struct
Message-ID: <20180301152340.GI15623@char.us.oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=841
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010193
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593671064225719544?=
X-GMAIL-MSGID: =?utf-8?q?1593749392141973550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:28:02AM -0800, Maran Wilson wrote:
> The start info structure that is defined as part of the x86/HVM direct boot
> ABI and used for starting Xen PVH guests would be more versatile if it also
> included a way to pass information about the memory map to the guest. This
> would allow KVM guests to share the same entry point.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> ---
>  include/xen/interface/hvm/start_info.h | 50 +++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/include/xen/interface/hvm/start_info.h b/include/xen/interface/hvm/start_info.h
> index 648415976ead..80cfbd35c1af 100644
> --- a/include/xen/interface/hvm/start_info.h
> +++ b/include/xen/interface/hvm/start_info.h
> @@ -33,7 +33,7 @@
>   *    | magic          | Contains the magic value XEN_HVM_START_MAGIC_VALUE
>   *    |                | ("xEn3" with the 0x80 bit of the "E" set).
>   *  4 +----------------+
> - *    | version        | Version of this structure. Current version is 0. New
> + *    | version        | Version of this structure. Current version is 1. New

Have you checked if there are any OSes that end up checking this value at all?

Perhaps also expand the comment to say that for PV guests only 0 is allowed.
For PVH 0 or 1 is allowed ?
