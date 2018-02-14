Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x226c6EuNnjPlS3LkMSDok5hjmfs2RJW0rkbZwnRhXoyQuwLhqb7OK82CNBPjBCVfiHbyKYJ+
ARC-Seal: i=1; a=rsa-sha256; t=1518597171; cv=none;
        d=google.com; s=arc-20160816;
        b=t9xYyCJ2kT08foBFHRsCOGLYYyxKfamj+23GIxKoGzfXwRdXYGZBt0C67hzISjyzpz
         Xzcp1wBZpJ9duU8WTOYOvS4P9RcnsNGmiX69oOogWdyQEYjhUt8V2AcSEeDdtKLlUQo1
         2ylb9S01Dukqo88Vs4sWPMfjTdtkkbeEvh4PYtJiI4euo6qse48GT1rovJVDvW/vRSb0
         znYDu3WdGGuk7Y8APVjVyh8VzY6dHD2Doao+HdxpEc/TZFdMQ2Ek/jOLSNElg5YVCwou
         AasrN0ubB9ZZPmwGqg6U4mXxisBfDmOgkeZ8lPowhLKKPjZx8++/h138KtX8LebzFUis
         BP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:arc-authentication-results;
        bh=leEcykurPKH4vZrF3uIO3XlLnqRCnASPuU8dKA0xvdk=;
        b=R2wd9Qp55mbcYci5yqYxNAvCj3nXQftDlFMtDcU+TSWkjeVSnEeCKzOwf+NsnPbf4b
         nJ+DlByX6LCMTo08F3zU02VAYvBY0Gpz1IxTfWVVbxeDxycFXcDjL/oEg3RJmwCXgsfu
         /SDGeaZ40J/XAQiFcwyYoRz9uz4J+kFmN+NzMooQiS52qozULvL68g8lmGurAbkVspfH
         /uq7Bi9Yq301HYKPzD+0mjQ3p96CyyEUefewNjSj8RNGLm6Z8fa5lIvi+/SkBhkueLXn
         9Rpc8TCofn2EF6mivqzGSNZ3OiSeXLAytqSQQbPvrJGvTM3V/nzeJJ0YZ5xoW8M+xhOL
         eoTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Message-ID: <1518597168.24629.4.camel@suse.de>
Subject: Re: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for
 LSB encodings
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 bart.vanassche@wdc.com,  axboe@kernel.dk, chris@chris-wilson.co.uk,
 tvrtko.ursulin@intel.com
Date: Wed, 14 Feb 2018 09:32:48 +0100
In-Reply-To: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
References: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592351049846277975?=
X-GMAIL-MSGID: =?utf-8?q?1592364548180620804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-14 at 10:28 +0530, Anshuman Khandual wrote:
> This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
> SG_EMARK definitions without any functional change.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  include/linux/scatterlist.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/scatterlist.h
> b/include/linux/scatterlist.h
> index 22b2131bcdcd..63d00bdb2fb3 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -65,16 +65,18 @@ struct sg_table {
>   */
>  
>  #define SG_MAGIC	0x87654321
> +#define SG_CHAIN	0x01
> +#define SG_EMARK	0x02

SG_EMARK sounds strange, what about SG_END?

-- 
Johannes Thumshirn                                          Storage
jthu
mshirn@suse.de                                +49 911 74053 689
SUSE
LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane
Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38
9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
