Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3347819-1519921297-2-17734479508006815724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921296; b=cBNRjQbVycW5r89oZqzeT3iwF5w+WtzAIUJR+OJZYsaI+JI
    bmeiyDeUM56tgHZY9cJsYu0DYr2FoLC7t9wtjs4xvNmWN8MVXNunkrCX1UGwAmqa
    WrD2fGN+DdxlTIJYz0XTNUWARhAQJ7mz1sI3WCkz03mL3QFjVogqEM2MLTWkuUbJ
    oVFOckisVmJgF+sHQcpKFu2j3OLhHtRNg6RXjn2UtDQ26ef4QryUYul6Cjj8tipY
    +U3ayhKkWFcQ/0pZCMUro2KolWSCrcVhojQhQApaxqAagfWm6a2zcItRUza+bAEO
    uE/et+cujXPHANMSwj8L0CbV39Vl/tr0llvHoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519921296; bh=W
    TA/XVYL40qVrFonhab/gR2FeFP96vKPXk6d/xaMNjE=; b=o+2650Ms9Kc04Zvek
    GCPlMFrM05b9Bz/MqG8pIw0kMylmQEZQVl23exugPqglVy+00WWKhd9AuAuF39VP
    E4xyGN5n9VRwpGJsloaN97dBWhvcNZNK2f+dm9dCyah1D6BdAsXdYll18sg4c5R6
    XEEw9yBJ1FgQJa0OMDYISzsM9XqGR4AcIl5nbOsidrVYQXUAN+8TuOS5C4RpGDf+
    5ofg8cXFXwTSY9Jcm0SMVVw/4mvLTdTRHXp/T4esaw5bDeLVKnRG1CfEkF5reGc7
    jtYujnXwOStoyK9Lz9Jci+c/WQK9RQ1aESaTnEiSZ/2hD8LodzI+xML9nxE6//ME
    iL2GQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
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
Date: Thu, 1 Mar 2018 17:21:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 2/4] staging: most: Replace calls to BUG_ON() with
 WARN_ONCE() and return.
Message-ID: <20180301162130.GB15087@kroah.com>
References: <20180224075835.11618-1-quytelda@tamalin.org>
 <20180224075835.11618-2-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180224075835.11618-2-quytelda@tamalin.org>
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
Cc: devel@driverdev.osuosl.org, christian.gromm@microchip.com,
 chris@engineersdelight.de, linux-kernel@vger.kernel.org,
 Michael.Fabry@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 11:58:33PM -0800, Quytelda Kahja wrote:
> Replace calls to BUG_ON() used to check for NULL pointers with WARN_ONCE()
> followed by a return.

Are you sure this will work?

> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/most/core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
> index 18157dd80324..3f65390a6e17 100644
> --- a/drivers/staging/most/core.c
> +++ b/drivers/staging/most/core.c
> @@ -916,7 +916,11 @@ static void arm_mbo(struct mbo *mbo)
>  	unsigned long flags;
>  	struct most_channel *c;
>  
> -	BUG_ON((!mbo) || (!mbo->context));
> +	if (WARN_ONCE(!mbo || !mbo->context,
> +		      "Bad mbo or missing channel reference.\n")) {
> +		return;

How is the code supposed to recover from this major problem?

> +	}
> +
>  	c = mbo->context;
>  
>  	if (c->is_poisoned) {
> @@ -1001,7 +1005,7 @@ static int arm_mbo_chain(struct most_channel *c, int dir,
>  void most_submit_mbo(struct mbo *mbo)
>  {
>  	if (WARN_ONCE(!mbo || !mbo->context,
> -		      "bad mbo or missing channel reference\n"))
> +		      "Bad mbo or missing channel reference.\n"))

You did something different here that you did not describe in your
changelog :(

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
