Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-560798-1519060152-2-13530914247523249982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519060150; b=prsRh9SQhd+lMyzUEv9VYigd77sFBu3exg3SAgt6jfYirwP
    Pw5nfIHC3DCgI7KYqVkmcRMpcqUr7aVVWArycI6z0pqzofF/sMkHps6HeKzwaHwQ
    JYQxOluVXA9OCJvlUht4l7g/D7Q3WEMXGU5UzGmvxGHZuQLdXontnEPkRReo7oIK
    ZaFI5dKQujQqfc6ibw8vK5LzrH8NKrG9R3bpXBuS6kSPGBBIXTRJZIgvoh9LM42o
    20Cvg1I2YyZ2NOp7NCz96XDXFPSeBs03eoSih3td7p0yNor6K9VCmW3s2n30UUVD
    o4B0n0e1w+F/K5KHcXSxTkep+9BybuPzax+hhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519060150; bh=9
    KV0E+soKhWlSRu7LTGy5TV6dUzcRMPhVgdkAE3ZXjs=; b=IxtdSg/816Fv62/aP
    HY7xG96vUaGrVIC9Pb6bgofb2H1RN+Z+DnzGSci8iXyeB04tkNOSoQ4X2cz0Q5ch
    IMkjE6kSUWJ2Lks8E/BK0QObWUh0bbBouJl1JaoaMV/C8XbKFl6XxhGldnGNbMwO
    NH1viqwOQD/nSP3JUcQ4Jw1tS+RsNoiCEVyjW/lXvTPljC28TVhukYrOCP1YK+Dp
    frBpaVP9+DRk1xYgGunXy0klc396f3V1VMDdDizDYMCAzvjR5JEGJ0HKzJ8kcOlG
    rKesPSyObd+fX1lI1wegClOpgQ06k4nd4Fv7IBRzDLfwIXUwVAN4Snl6ebD1H2Iu
    MB2AQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Feb 2018 18:08:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 2/4] Staging: ks7010: hostif: Fix multiple use of
 arguments in SME queue macros.
Message-ID: <20180219170839.GA3632@kroah.com>
References: <20180217022503.24982-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180217022503.24982-1-quytelda@tamalin.org>
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
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 06:25:01PM -0800, Quytelda Kahja wrote:
> Use GCC extensions to prevent macro arguments from accidentally being evaluated
> multiple times when the macro is called.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 975dbbb3abd0..30c9592b3a00 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -22,12 +22,19 @@
>  #include <net/iw_handler.h>	/* New driver API */
>  
>  /* macro */
> -#define inc_smeqhead(priv) \
> -	(priv->sme_i.qhead = (priv->sme_i.qhead + 1) % SME_EVENT_BUFF_SIZE)
> -#define inc_smeqtail(priv) \
> -	(priv->sme_i.qtail = (priv->sme_i.qtail + 1) % SME_EVENT_BUFF_SIZE)
> -#define cnt_smeqbody(priv) \
> -	(((priv->sme_i.qtail + SME_EVENT_BUFF_SIZE) - (priv->sme_i.qhead)) % SME_EVENT_BUFF_SIZE)
> +#define inc_smeqhead(priv)						\
> +	({ typeof(priv) priv_ = (priv);					\
> +		unsigned int next_qhead = priv_->sme_i.qhead + 1;	\
> +		priv_->sme_i.qhead = next_qhead % SME_EVENT_BUFF_SIZE; })

No need, just make these real functions please.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
