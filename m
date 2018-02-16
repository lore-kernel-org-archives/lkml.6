Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x226Toccls/g++9H8AVtt1+8Lf2TlzfLlWtcwIGYJhf31zT5qRqaWvegtRq1qod7NFp7wNDIa
ARC-Seal: i=1; a=rsa-sha256; t=1518785736; cv=none;
        d=google.com; s=arc-20160816;
        b=ixqiKoP++q3h+3Z/mSA+YNSWmmbpduQnncE3HSc0RKb0sNXUI5drMgXEOQG0JgdxWZ
         RW7qkscI4y95yPXYDaM5w78fbX7hDq/BLcVo4k52G0l5ZDKwDastApyy6RwVP5L/XyAL
         yVuOBOaCOx8hsCcGdJv0Jrgn1zLi/XA0LqKbKP3FjWaDNFil4dgCbEu2WpmImFlHvbAt
         OmakgknQzSuOvs/p03qzUPzQs4Ez7ro3GO8eusORKvfwFlgLx8C/jpVzaoC0Bluxlm86
         /EAg0ejvyhW0ixXQJTad0D8acn2/+T1+K+YVx2FbhMI+LgeRkYQsRwQnGKcyvAv2FuWQ
         7Ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=UTSrvdIKi6H9RrMAqxnrP0pbFIAR98lLb4GWNcdFNLw=;
        b=KAL+B050U7lLrlt0ibqx2dHdKAzbAv5ru2MemaLrIIEIliyWgL5rjHpvX/TBfLR5Zg
         jjkUEGEB4EQy9THs7L5lOuak0FtgMXTVNsu2r1lo+438eCMNwGghOtEt8qt7ZbKIbbaK
         u7h1Y141QJ+ssABR0++ieFjxa45oV5WL2vsz3ZPFcok86S1e739pmRI1lgnPpKkWzp0j
         y2PbThN/sV/TN/eZh2+ka/zq97yQj8xYvQzlVE4YCEBHZAh3iXavl9V2S51TCuqXyqeS
         MJA0+WvMbyEkC3WG8z+B7W4t1S5H0BNI2UPpf8hne/GtdeFzxief5kugsSf1VKLZGF0C
         H69g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Lcly1cj2;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Lcly1cj2;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 16 Feb 2018 15:55:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Yash Omer <yashomer0007@gmail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH] Staging: nvec: fix line should not end with a open
 parenthesis.
Message-ID: <20180216125519.odsteynuaielxpet@mwanda>
References: <20180216113634.12848-1-yashomer0007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216113634.12848-1-yashomer0007@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592557310157839055?=
X-GMAIL-MSGID: =?utf-8?q?1592562272927564676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 05:06:34PM +0530, Yash Omer wrote:
> This patch fix line should not end with open parenthesis found by checkpatch.plscript.
> 
> Signed-off-by: Yash Omer <yashomer0007@gmail.com>
> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 52054a528723..39fb737543b5 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
>  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
>  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
>  		nvec_gpio_set_value(nvec, 0);
> -		err = wait_for_completion_interruptible_timeout(
> -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> +		err = wait_for_completion_interruptible_timeout
> +			(&nvec->ec_transfer, msecs_to_jiffies(5000));

The original code is basically fine...  It's OK to ignore checkpatch in
this situation.

regards,
dan carpenter
