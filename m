Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZpWKRVq6/okY34tTpsMxu2LuCGenszSZBuo6rYKg3Rv0GICW5q478t5aowRcqqHlqqoihh6
ARC-Seal: i=1; a=rsa-sha256; t=1524124300; cv=none;
        d=google.com; s=arc-20160816;
        b=BOKJ9AJGSNnsd/iSoLmnC9vN3cQvrxz9ZSeDbIzYuXkUMoGGbmeKB8+7yg8qSoX3Xw
         PEFyNkUiiyFOtcdLzDhkAFGQunGEKHC6fFtVG2OT9mIvqyN/12AUMGw3U76jXVALruTk
         CENd9ve5spUu8AjXKWYvh4pzE8j+LJngcyNkm58xv2dl/uRFRFpM9oUmCRpk2Ys5X4Dh
         vRXpJomVqLD1QDzNtoAQppx1RmLTaoXJPGztsA0AnCIvG656FyLMEdr841ugdswXiHAe
         UxnZmYZWshWvj8tde1JSkfOyD4v4K/h0Xa89vP8tD9s+RJsAXsNvRh3b+hjJXyGQ6CUn
         Apfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+7EWEAUXyWjMrxPINExJcLJC2DrCPCTaPfz7z20OCsA=;
        b=KQ96tQgTZcGyPk6ax/RH615EqzRCHarObfAh/DcsJAan2FLvR76yvn6DSVB/KUMfzH
         mXrWWnjHGz21ClH6BvxAIrTrKn03PV4M8pztddB/ygXUBS87BqYywGc4fb/h+jHVomEU
         EsF/9vNqBqnOfpjz8csxXOEHPbvNr/12seZ2CNb2NoAAbMkhmkqvuPJVAm9B8uwLWfG7
         mSl1vuL5SaQqSvifAoyRLguFoy5P2fpZ5im0DJudrGfbhG4pvjz+kmyU1knkk7F51e5W
         /MLb92Ec46uCoLCqazt6SlL6bow8DF17ANhiN8pTOmzVV19m6ZtXvV8uzPhJj1g17267
         qXeA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=O90jczZR;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=O90jczZR;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 19 Apr 2018 10:51:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Andrew Jye Shih Chuang <andrewjschuang@gmail.com>
Cc: William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>, Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp-request@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: speakup: separate 80+ chars lines.
Message-ID: <20180419075117.bc3ppzxqhrbl7blg@mwanda>
References: <5ad83b71.1c69fb81.f8458.0d85@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad83b71.1c69fb81.f8458.0d85@mx.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=620
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190068
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598156108723047342?=
X-GMAIL-MSGID: =?utf-8?q?1598160162228925029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:47:10AM -0300, Andrew Jye Shih Chuang wrote:
> Increase readability of code following the Kernel coding style by breaking long lines and thus eliminating the checkpatch.pl warning.
> 

The commit message also needs to be wrapped.  I do it at 72 characters
like an email.  Roughly around the 70 character mark is fine.

> @@ -1233,7 +1234,8 @@ int spk_set_key_info(const u_char *key_info, u_char *k_buffer)
>  	key_data_len = (states + 1) * (num_keys + 1);
>  	if (key_data_len + SHIFT_TBL_SIZE + 4 >= sizeof(spk_key_buf)) {
>  		pr_debug("too many key_infos (%d over %u)\n",
> -			 key_data_len + SHIFT_TBL_SIZE + 4, (unsigned int)(sizeof(spk_key_buf)));
> +			 key_data_len + SHIFT_TBL_SIZE + 4,
> +			 (unsigned int)(sizeof(spk_key_buf)));

This cast isn't needed.  Just change the %u to %lu in the printk:

		pr_debug("too many key_infos (%d over %lu)\n",
			 key_data_len + SHIFT_TBL_SIZE + 4,
			 sizeof(spk_key_buf));

regards,
dan carpenter
