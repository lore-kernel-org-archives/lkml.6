Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-560798-1519059888-2-12277250862382901875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519059887; b=Xk13qcP6MDNZHx5Yfnd9NXku6BSCGQcggIGtw3Ghp8A+Ynv
    f8VhL+MwcMi9a+umXBuulelRmfhWqd+fta4TkWi0c7wjOyWupNbjUDVdJkHUFfHu
    4Zlbl0YFlErVJ4iSCIipNehNhEg+JE66K6dahuVvRqYQQPohMAHmcq6JD9fk26V9
    aQTkp47llu4ByD0WYEEcn4ABSmIqXQ3UYG7ils6y83IhIqnpHvHh5Xfam/xXd6X/
    z+TNcQPtt8H+MjBNti9RmsBl1m5qE87uU6HS/zJI968Xtg6gEAUWsDJ0oJ4cBXJ7
    RYvO70v10rJaQdK14mMe086oRbZg5iU/1O3VlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519059887; bh=J
    daIEgWEsKuYFUa28O4HmNwvYp/4ljH1UBry4/ED/AU=; b=T7iDpLqgqCnGP2stf
    rxWw8tMmydNKJUOJ1TFNAufQIrVwaBVi6e6DRYDv3b1NHwcEkEuy6+NCcOnkr8Ux
    XSTysbIsOJ9HXrjD83AjWzE5D1cgFsbQR83vHc0fRIX9GR4mLl+g6bg0W3uP9gc0
    af4K/dc4eUog1PlwA6A2LlDANHbVc57qkjFxcoCm5zjm0ppPa6sxNENmGFCsF/qc
    cwQCh2QSppTDxInEgsG9ydPoPg6/57JToK58avC0dUQvdGqbd+Of4R5A/9P1d68h
    wTxYDrs06VjLctWon/XaHY3IT+OqONwIRn4oa0A22eEXrzczqBWVzwxKp76aTabJ
    dNTpQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Feb 2018 18:04:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yash Omer <yashomer0007@gmail.com>
Subject: Re: [PATCH] Staging: xgifb: fix lines should not end with open
 parenthesis in vb_setmode.c
Message-ID: <20180219170439.GA18723@kroah.com>
References: <20180216184236.10963-1-yashomer0007@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180216184236.10963-1-yashomer0007@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 12:12:36AM +0530, Yash Omer wrote:
> This patch fixes up line should not end with open parenthesis found by checkpatch.pl script.
> 
> Signed-off-by: Yash Omer <yashomer0007@gmail.com>
> ---
>  drivers/staging/xgifb/vb_setmode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/xgifb/vb_setmode.c b/drivers/staging/xgifb/vb_setmode.c
> index 1fa0dc66406e..1d6ac724fd61 100644
> --- a/drivers/staging/xgifb/vb_setmode.c
> +++ b/drivers/staging/xgifb/vb_setmode.c
> @@ -1228,8 +1228,8 @@ static void const *XGI_GetLcdPtr(struct XGI330_LCDDataTablStruct const *table,
>  	return table[i].DATAPTR;
>  }
>  
> -static struct SiS_TVData const *XGI_GetTVPtr(
> -	unsigned short ModeIdIndex,
> +static struct SiS_TVData const *XGI_GetTVPtr
> +(unsigned short ModeIdIndex,

Ick, that's horrid looking now, don't you think?

Please don't change things to make them look worse :)

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
