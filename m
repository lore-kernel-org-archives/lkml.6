Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3296274-1526622000-2-2961754442825013597
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526622000; b=XEIGmF5AH9Y5KExINzf9spon4ZqXpjz0GIq32dnU861RJ57Dzw
    PS4/qONONiffu3BJ2OelrP2Eh5PhBNetwnb0Unvg9YnkgV8uOvBqGSOrnRrqy3y5
    oare9CVjs0LCy452RrWZ+lZQjq4TpowGe7xXkzj1wz5500mMwzq8OXvRvhhZER/j
    p8DyQyf4DKFzAJ/FJq/ROC9elcF2Wf9HU9wNuEqFRCna4+h5wudlv1HmbGWKhix8
    Lo9ztdgfkKq/LqkR7P+B8sSEVnDDEiRVE4yiixP9RWmqC9mfy0wtmHXsSfvLCD0c
    HkWhDm06OXorMMpeVFI1TrW5Ynewsy9uahgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1526622000; bh=rixCJ447thnf
    +S+8Rn9Bl62+Om3qjYAWiNlBvKsbPh8=; b=mI4JPe9FBDxtSR9yNu31epJPmAn9
    ELJH/9DmELQRI4yS9mLD/Qi0+A4NnLOr0eJV6MuXnBlfN83clMkyVB0PFI7Gp7ru
    4zUb5rkv9pCx03foirRl+KFj2j2BwwdngEENrsCaV0nNOmDjZAZ/O1qew6QP6hgb
    qamH6/rgRDcap4oGY7DWLTyqVRLnWE187Q+/Xk9e54ga1q1gy2VBhFknrhkpHipz
    tD0SjKJ5BSXK8a8M07xavoOnqjrvC9FsbKC3Q9E4reupTqomt4ltQcATWAbYZ6c1
    dNxk9gAJLCAqhn4PKNp7wqHMm3elCTQ6aKBNMczI64jzfEvS6CAXpmQrYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=samsung.com header.i=@samsung.com header.b=nouiXc7L
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=samsung.com header.i=@samsung.com header.b=nouiXc7L
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHQ+M3G7Ok4LRUS5OaoCZB5fvOSxc6yjNAmcq/Mj1LpZaXb2BCmekwa0k5xWYizTYt7mwNJChymp4dFZdMAKDco272vjeSc9VtgdJwLeS+g+/IwdqLo
    /qWCXI4uX8L/PrwZIoaMekCKw1FFV2aFHbvSG/9XYgeDIUbyDBHfyA00InbjM7z6+W+JWU6M5ZKlN+gNtWkovobN3FeIpskPfAFMGdJA4W+bFUxli1iI+n8+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=IlzZQvGxnmr6KL5XCuMA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeERFjy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 01:39:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56199 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeERFjx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 01:39:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180518053951euoutp02dba11255ab1054f9980f82945c25a7c8~vppzfSGq_0385603856euoutp02T
X-AuditID: cbfec7f5-b5fff700000028a9-5d-5afe672584bc
Subject: Re: [RFC PATCH linux-next] USB: dwc3: dwc3_get_extcon() can be
 static
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8b363802-50f5-1da0-0879-fe8d38231f5e@samsung.com>
Date: Fri, 18 May 2018 07:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517160641.GA55289@lkp-ib03>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7qq6f+iDD5f47aYfzPJ4v3z9cwW
        zYvXs1kcuz6R2eLyrjlsFouWtTI7sHnc38vusXjPSyaPeScDPfbPXcPu8XmTXABrFJdNSmpO
        Zllqkb5dAlfG+Z0PmQo+sFVcvrOZsYHxOGsXIyeHhICJRMvn/SxdjFwcQgIrGCUebmhnhHC+
        MEq0nGuAynxmlNh/7Cp7FyMHWMvNCfkQ8eWMEtNm72GFcN4ySqz+MI0dZK6wQIDEzDkvWUBs
        EQE9iRUL28DGMgtsYJR4e/sIWBGbgKbE38032UCm8grYSSxalQwSZhFQlZjZ18gEYosKREg0
        Pf8JVs4rIChxcuYTsJmcQDP/bbwBFmcWkJdo3jqbGcIWl7j1ZD4TyC4JgXXsEn+WzmODeNRF
        YsXBSSwQtrDEq+Nb2CFsGYn/O+czQdjVEjdfNLFANHcwStz/3Q7VbC1x+PhFVpBDmYGOXr9L
        HyJsK9E1YwITJFT4JG68FYS4gU9i0rbpzBBhXomONiGIakWJ+2e3MkPY4hJLL3xlm8CoPAvJ
        Z7OQfDMLyTezEPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhyTv87/nUH474/
        SYcYBTgYlXh4J/T/jRJiTSwrrsw9xCjBwawkwmtl+i9KiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgVFOxs5Z+sfbhZVqkpv2Xedbbxeb6qf20SHCTePr
        h3iHoC1ZL/4IeJUs62+qPeTpGOAn+d2wsW9ioZ74LMWUc3fnzm6ZZrb9Q+tP3Uy5XXc2PGZh
        8/bf5mxad7LMYOnsf38q4z69efz4VFsxZ48nR4jRysdsfqsvXFrkM/2H6UYlIak7D7nSviix
        FGckGmoxFxUnAgA3Duj9NQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7oq6f+iDDb8F7GYfzPJ4v3z9cwW
        zYvXs1kcuz6R2eLyrjlsFouWtTI7sHnc38vusXjPSyaPeScDPfbPXcPu8XmTXABrlJ5NUX5p
        SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G+Z0PmQo+sFVc
        vrOZsYHxOGsXIweHhICJxM0J+V2MnBxCAksZJR6/rgWxJQTEJXbPf8sMYQtL/LnWxQZR85pR
        4sU1fxBbWMBP4tu2PSwgtoiAnsSKhW2MXYxcHMwCGxglLp1/wgriCAlsYpTYf74VrJtNQFPi
        7+abbCCLeQXsJBatSgYJswioSszsa2QCsUUFIiTunf8EVs4rIChxcuYTsAWcQAv+bbzBDmIz
        C6hL/Jl3iRnClpdo3jobyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430
        ihNzi0vz0vWS83M3MQIjbNuxn1t2MHa9Cz7EKMDBqMTD+2Li3ygh1sSy4srcQ4wSHMxKIrxW
        pv+ihHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfGP15JfGGpobmFpaG5sbmxmYWSuK85w0q
        o4QE0hNLUrNTUwtSi2D6mDg4pYBRlLOxsa4+TfAX/1R2puWv/7/lyw25pXDKSqch3+wv466J
        c0SV8mx2CP2x7u3UDZ6/4Crjb6aTj/vnaSqK//p1/0DMDEV/TWvhK3Mf7+YK5o9tvhZc0d9h
        9fPGhXs1rZafHi1ZKGEqvO18qniB2gSP/U8/LXz8awNbBIPhEZsdxRU3d0Xt0H2vxFKckWio
        xVxUnAgAxcLEkMYCAAA=
X-CMS-MailID: 20180518053948eucas1p2241e5806baa6f3ae436f312acda0cde5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180518053948eucas1p2241e5806baa6f3ae436f312acda0cde5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a
X-RootMTR: 20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a
References: <201805180059.3X1bJsDZ%fengguang.wu@intel.com>
        <CGME20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a@epcas3p2.samsung.com>
        <20180517160641.GA55289@lkp-ib03>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 17.05.2018 18:06, kbuild test robot wrote:
> Fixes: 5f0b74e54890 ("USB: dwc3: get extcon device by OF graph bindings")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

It should be static of course, my bad.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> ---
>  drd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 2706824..218371f 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -440,7 +440,7 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> -struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> +static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>  {
>  	struct device *dev = dwc->dev;
>  	struct device_node *np_phy, *np_conn;
>
>
>

