Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-780251-1520229689-2-6439235423455847603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520229689; b=aYYsDyxLKiN74R6o5YI+kh4MGlbT1yl0am7kCuZgxl6LDDy
    ucrtLXe6qyVwA17/0NOw3zwGI2nzZnSQ4NARXC/BlFMOMHbJhrabywsn2CYhPa4q
    MagSTLOqT6N8ZcutDWcHFV9SuILQwdYYZuIiQGe0x7ZtuJ3ZdWoHsgkwpsVd0pEJ
    vJSs9MeOHgFGHDKvuURnPg3rN9TsvzYHofX52brmIsDXZ0EGem3QzRmzQEsxUjeq
    z5fT6WwMeMMREKWXx78i8bTUeqwEYJTsnJvkq3nQOpaY6xS2/6UXnBfRO+ThQubn
    0kyTiEhmvknEH1KoOhQfzplJS6pbNPvwbgsMn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520229689; bh=p
    KhlwIhgvqDjbZr9fr4bzfmGItxBxwZN/pUe38w8c4M=; b=SeBF4aD60PZHz125u
    FifuoB4mmt4J+c+hIzSrWP2iqejvFDpQW1jIVrTciTLf9IW9YH4rqkHAkYiP210L
    RYny6z5iymwj9CI45cCkLcHrQIY1FMnnxdr0/iqDxWw11PepXlPFkc9ZPxsNnLO5
    XlGBQeO8Iz+rUA+ev5m80opy643JiqoBLx9WqTfoxgeEd7UsM/hrOPR/YuUSoCKN
    trvG12zpwlO9A9PTCWBBOinLs9TqT8tA6k7xsukyxWwSf8AMEFrwLis823uwejnz
    XVFTqXPL7rI97/1SMqZPLprNHb7fSbU3Vlcjs8+nMaZDE8OWCwg4je5tsSOr3oAn
    6KwTA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 5 Mar 2018 07:01:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [PATCH v3] staging: ipx: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180305060121.GD6670@kroah.com>
References: <20180305041740.GA23378@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180305041740.GA23378@seema-Inspiron-15-3567>
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
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 09:47:40AM +0530, Arushi Singhal wrote:
> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
> *In v1 printk was changed to pr_*macro(), which is used
> in kernel instead of calling printk() directly. And for drivers,
> dev_*macro() or net_*macro_ratelimited() should be used for calling
> printk() directly.
> 
> changes in v3
> *Indentation is not changed, as line is exceeding 80 characters limit.
> 
>  drivers/staging/ipx/af_ipx.c | 2 +-

Did you read drivers/staging/ipx/TODO?

Please go do so.

sorry,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
