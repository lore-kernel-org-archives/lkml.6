Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1528056-1521027506-2-6625341444108484128
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
    t=1521027506; b=GpBQBQ8973xOSYgQ4PZTgavewglPV7U/I/F8QDLhoBm1PCr
    71Qs7abpPx4OnVq9jyFY+vu3RtzdfsBddHr8MvTzDcJckA/OIY+QskchwQi8AvVS
    ysHBLOeXfU0IbxHMdu/5kshdo8ElqKKb7ehxo39DzYouwnyB1Nrsz/p+qY2SzIBu
    hhKRw55vixE7EtZYt8F3h/KbECI9+w4RHo+QJOd29naALCpWtPR3Zw4fJoGVcyir
    /7N5UL6v2K+MJhjSN3kdRCEs9NFWozy/ffl5K2cjcchDybqY7e0Bu9LOzB1LqWP5
    lVdPd8x8BhRqQLj40KBrCkq/yMQlLGG6WMzsX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521027506; bh=l
    GkSuU5Caqob6+uNPXVBGROGrBtLePmV7k486YZ16Fo=; b=RmU3BUIZj18L8dnJj
    spHYQf5ZHeFQA+IFKVcc7j9lZh/9CZeI37Jc4ii3IB0Jw8hQ2rChSMyShoKx6DfH
    TClqXrpMWurni1Ezf36iFQV4U1VyiNhib4JR88K48bZ73mLKcQ+hTF1vhMJxhdHy
    195D2bvhVZW9gjEfkHknHUibu51zW4yhNlliNIzF7MoCnUDFvD9qjKGM94x5zZmI
    pyrnYdk32VplujDfJSVaZdU8ZHx749voyM3R9U8+hubTxYuvACXKZyUDvkTcNjGJ
    n/1islVZZ8NeGBBGt3rh6Azuzubj6EOpN6onO6KXs8SyLzB+Tz5aIslgv/8KyRHs
    qFM7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 12:38:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: hariprasath.elango@gmail.com
Subject: Re: [PATCH] staging: wilc1000: use kmemdup to replace kmalloc/memcpy
Message-ID: <20180314113818.GA7169@kroah.com>
References: <20180313124932.15038-1-hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313124932.15038-1-hariprasath.elango@gmail.com>
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
Cc: devel@driverdev.osuosl.org, aditya.shankar@microchip.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 ganesh.krishna@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:19:32PM +0530, hariprasath.elango@gmail.com wrote:
> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> kmalloc followed by memcpy can be replaced by kmemdup.Also added the
> related error handling part
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> ---
>  drivers/staging/wilc1000/host_interface.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

You have sent at least 8 patches for this driver over the past day, yet
I have no idea what order to apply these in at all.

Please resend them all as a proper patch series, numbered so I have a
clue as to what order to apply them in.  Also preserve the acks/reviews
that others have provided so they don't have to provide that again.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
