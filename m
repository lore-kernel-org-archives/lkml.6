Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1821531-1521826694-2-17501735826397486711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521826693; b=r14cYXeR28/r9YlmKeaaIb+utJBxUxDViiJ+5X5XtwT7jzq
    INYwcrvC2KLg9qUjdEY1qh1IlheZOhewOt7xXaHHeUKGnc249VbrwCFzJuvlRV5Z
    ZVK1k8pRaZzzakfr+d1SPU+1lI3l/l4CnxhGM17vdc2OxgGCeKXEwN9dzYuIkDmE
    poKlaDjJctHzcvCENmEiRvck7bQ6Pgir/wkD6Fd3H+dZDa7vjo3XkKGMBiz2X871
    qJ1x9nfa+f+HGDGNgF3OYtalHqkfX3QWurzAEWTj2LP7XisZ5vv3w+f87EOLxCHA
    gnc5wVb9tciKoibzzsIvP98q8VMyAHtHUXjUVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:references:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521826693; bh=G
    OLSDcovO0sBiVND0+gza/hGYAaNMvzfTmhjhpQZztc=; b=XNkhtJyFUKJQzfAAf
    oH5vcRyxWJSw1S+hKm/GEUFTaYiNthzMIUpotXXQrsmMv9BI03FyMuNFHPvPsbQt
    nIpakdPMOT8hYHmQ7DYMjw3JPxJ4G5Fkrurlhkc2m0IjHBrObTOu/6GaBMh9t0qM
    YjDLZ2ng19h6sNqrz6OGu+sF+7NlemUWAxGCj+lCAvZophgaVjiYlTgIPBsd9t9G
    P15DVBj8A6311PJztHoatHV3afTuRXqFxU/SWl6pHCAS67xFrDg0sAQhV89w5Nc5
    iioVjPGKpNNDm8W3vxrMQf0b0Jx1FBFt6ql5fqjvSY/uZbVr7FwVT6fEJ9MHOL5z
    pfhxw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: NACK: [PATCH][next] staging: r8822be: fix type in guard macro
 __PHYDMKFREE_H__
From: Colin Ian King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Larry Finger <Larry.Finger@lwfinger.net>, Ping-Ke Shih <pkshih@realtek.com>,
 devel@driverdev.osuosl.org
References: <20180323173606.21119-1-colin.king@canonical.com>
Message-ID: <ef81a7ea-50b7-b296-e46c-186c54a54127@canonical.com>
Date: Fri, 23 Mar 2018 17:38:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323173606.21119-1-colin.king@canonical.com>
Content-Language: en-US
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/03/18 17:36, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The #define for __PHYDMKFREE_H__ is missing a character and is not
> the same as the guard check.  Defined this correctly.
> 
> Cleans up clang warning:
> warning: '__PHYDMKFREE_H__' is used as a header guard here, followed
> by #define of a different macro [-Wheader-guard]
> 
> Fixes: 9ce99b04b5b8 ("staging: r8822be: Add phydm mini driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtlwifi/phydm/phydm_kfree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtlwifi/phydm/phydm_kfree.h b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> index 1ee60059afc1..2c6b0a48e76e 100644
> --- a/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> +++ b/drivers/staging/rtlwifi/phydm/phydm_kfree.h
> @@ -24,7 +24,7 @@
>   *****************************************************************************/
>  
>  #ifndef __PHYDMKFREE_H__
> -#define __PHYDKFREE_H__
> +#define __PHYDKKFREE_H__
>  
>  #define KFREE_VERSION "1.0"
>  
> 
Scrub that, I'll send a V2 of this.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
