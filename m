Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3249925-1521739195-2-4960088710122550480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521739194; b=kdR9XUmpGzo0d6LNPm6uA+TEMlEuZ2FBCX1+kjBl83gk5PM
    bjbJWNHtmLndJkSUGthQTVNXf+n6Wai/C1A1F6nvs/e76WPVeoxchqnmCkHlw6iC
    yBtV5u8M28mozuZ2dFXwcuaTd9H5nrsrPIg6o0JERX6gNlPyxgIcc5hSDKn32q7L
    OPpPh1n98A3LBrUlrzfimsTpGsF1fyTu/Z3iIu9Xy6dnMkHeX2buz+uy1z0H/5Bv
    c3/hxi2FZSASmOUjOpj676E0cOl2tjN19MwmxtkR0mhvebxUdKqqdF9VdSR+UQBK
    GKEjDvBvCOjugtCcVBdFxTtWvAsnJXvG7Bm2wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521739194; bh=y
    wbgskpJrIpXjLXHBruXDRZaLyiNHdNOcqbWH/iChng=; b=lq5ouyLjcusudbP8d
    H3wH36p9yTOFUqTycSuZAvltRTHhJY09BgTpvxCwmQ62WbNiJbwoQkNh6pXOjnJP
    sJZ+YfZ162B7elZGCoIhio6jaO77YXjupm9XKagLA+KAVrNtT50CGuO8pzFuwwo0
    FrSPHAwyDFhGfi7XuVkix8X9f/Bi7xWZOLBEPpjLWOidqfoyYGE3KIC9dRJYX5fR
    E08XShk2/WyYJWCkl0tJ7Mtr7UZvPyJXMnGiaU03JKB71o8L+7L+fzoSgVc1/4Ps
    EolxV/dWXpG1ONMPBw/g47GY5a0pTFxSn8TMpvCynf5RQiyfhMHehuQ0gJEoTvLr
    jcRZQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 22 Mar 2018 18:19:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 6/6] staging: ks7010: Factor out repeated request
 initialization code.
Message-ID: <20180322171944.GB5434@kroah.com>
References: <20180319185125.GA13209@kroah.com>
 <20180320055815.32651-1-quytelda@tamalin.org>
 <20180320055815.32651-6-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180320055815.32651-6-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:58:15PM -0700, Quytelda Kahja wrote:
> The code to initialize various different types of request structs
> is repeated multiple times.  Factor this code out into a macro
> called INIT_REQUEST.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 55 +++++++++++---------------------------
>  1 file changed, 16 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 6fc2c3647908..3e5016aad029 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -40,6 +40,17 @@ static inline unsigned int cnt_smeqbody(struct ks_wlan_private *priv)
>  
>  #define KS_WLAN_MEM_FLAG (GFP_ATOMIC)
>  
> +#define INIT_REQUEST(pp, priv)

Ick, please make it a function if you really want to do something like
this.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
