Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3955644-1521762814-2-12054092671642280547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521762813; b=U8XnoT88sZSahU6drr8EDk1QpYri3SsF1MkV+GljTHAn/aE
    G7tnX8Pf/lbA6IptNO+InPM5f1oTe5yU3pnLv/6PIcPYl6n49Eo9Q9MzLPz00oP9
    Bk2QPvUOald06kZqqEug7gDi0O/i4wA2Ke1lwR7CnOB4l9YF1BrIN2HEk1sn2VkF
    5zsszXJBJZ88qlph3LNzRx3OzdSIaox1Zn2JF94xTlQZdEp+tO4N1eue4aqMAZb3
    jL/lJxBOinc+Ruhaj6L/UBdSodO8CDdKQxEWqWVcYrYO7bTGQiKmNqPCroICWbQ8
    WA3+uqeU+NBgPpFVXuR+luJgJTKKEKZcqX28TlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1521762813; bh=pRn9uxtJ
    f3a95/zWsZhj8EvLNA6PSf3I2V6mPTv4ENE=; b=e75nNBa21gePbBSldHQuR8GH
    HbPkmxapz8dL+VIfJSBKEBb+ZWorrYk/dZZkuv8HDmE6dbkfbQ9udJJjDZozQAHF
    0zInJTvaM3dKGewSUstCKTvWjps94Na6/k1rZxVIkD/KtBUX8lSzI7jtn5mc//P5
    vYSSLm1vzKAGWDEvUDBZoJl88D/PLmSDdRnbpL2ehlRpt5FPrFjDn9aq0OMubqyd
    vBf43KIkc2XeDGWSkVEfRAZlwRtJgd6Md7AamasF+l5PL/B54yI2B1Y1Q5XzkWdf
    XfAZbFmqcl93griJBgoEgvMG9FRLIOB/zEsGG28nmt7OWiRJN754n2yywptUIw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=PQaauBag x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=PQaauBag x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCVXxU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 19:53:20 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:10094 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCVXxT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 19:53:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180322235316epoutp031afce83dca819a30c23e3607bf95d552~eYzNjT-2K2982429824epoutp03X
X-AuditID: b6c32a39-47fff70000000fc5-2c-5ab441ec5951
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AB441EB.2030403@samsung.com>
Date: Fri, 23 Mar 2018 08:53:15 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v9 12/12] extcon: axp288: Set USB role where necessary
In-reply-to: <20180320125713.85465-13-heikki.krogerus@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmge4bxy1RBhM+c1hMmvGf2aJroYFF
        8+L1bBZvjk9nsuhavZPF4tqxXiaLy7vmsFksWtbKbPFk4Rkmi+ZNU1gtbjeuYLNYvecFswOP
        x+YVWh6L97xk8ph3MtBj/9w17B4b3+1g8ni/7yqbx87vDewefVtWMXp83iQXwBmVapORmpiS
        WqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLCSQlliTilQKCCx
        uFhJ386mKL+0JFUhI7+4xFYp2tDQSM/QwFzPyMhIz8Q41srIFKgkITXj84m77AW3BCtWveJt
        YOzn62Lk4JAQMJH48Umpi5GLQ0hgB6PEwRdXmSGc74wSC87/Zupi5AQr+jZxLVRiN6PE2T93
        GEESvAKCEj8m32MBmcQsIC9x5FI2SJhZQFNi6+717BD1dxkl/p/4zQxRryWxdt0tsKEsAqoS
        jYtmsYLYbEDx/S9usIHY/AKKEld/PAabLyoQIbFz/jewQSICvUCLl29hBXGYBQ4ySdw7eBes
        W1jAS2LOkpVgGzgF3CRunvvKAlIkIdDNLjHjxUt2iB9cJH41v2CGsIUlXh3fwg4JAGmJS0dt
        IerbGSXa985jhnCmMEqcu34PGgDGEs8WdjFBPMcn8e5rDytEM69ER5sQRImHxKkvm6HmO0p0
        f3rKBPH/FUaJ56d/MU1glJuFFGSzEEE2CynIFjAyr2IUSy0ozk1PLTYsMNUrTswtLs1L10vO
        z93ECE6jWpY7GI+d8znEKMDBqMTDO+PQ5igh1sSy4srcQ4wSHMxKIrzxyluihHhTEiurUovy
        44tKc1KLDzGaAkN8IrOUaHI+MMXnlcQbmlgamJgZAdOXpaGhkjhvQIBLlJBAemJJanZqakFq
        EUwfEwenVAMjm2ASz5z7/06rth1x3Lom2aGj9OwCTlf5Hezf1xnctBcunXH3b2M/37Y1scEf
        bs/e4LnAau7d089YZWI5HTXveJrzfZj7m9dq8b/XodvFbk24Z9X8ILfiriXP4gVae+btOuNm
        KhQudyw9ke1ws5szH6OLv8fuG0/dF59tXvt/pUzqK53lfH1KSizFGYmGWsxFxYkAHhrN1bkD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e+xgO5rxy1RBr826FtMmvGf2aJroYFF
        8+L1bBZvjk9nsuhavZPF4tqxXiaLy7vmsFksWtbKbPFk4Rkmi+ZNU1gtbjeuYLNYvecFswOP
        x+YVWh6L97xk8ph3MtBj/9w17B4b3+1g8ni/7yqbx87vDewefVtWMXp83iQXwBnFZZOSmpNZ
        llqkb5fAlfH5xF32gluCFate8TYw9vN1MXJySAiYSHybuJa5i5GLQ0hgJ6PEkSuvmUASvAKC
        Ej8m32PpYuTgYBaQlzhyKRskzCygLjFp3iKo+vuMEi9nv4Oq15JYu+4WmM0ioCrRuGgWK4jN
        BhTf/+IGG4jNL6AocfXHY0aQmaICERLdJypB5ogI9DNKrLpzlRHEYRY4yCTxvuEtM0iDsICX
        xJwlK6G2XWGUuNt1Fmwqp4CbxM1zX1kmMArMQnLsLIRjZyE5dgEj8ypGydSC4tz03GKjAsO8
        1HK94sTc4tK8dL3k/NxNjMAI2nZYq28H4/0l8YcYBTgYlXh4F5zcHCXEmlhWXJl7iFGCg1lJ
        hDdeeUuUEG9KYmVValF+fFFpTmrxIUZpDhYlcd7beccihQTSE0tSs1NTC1KLYLJMHJxSDYxO
        b450zf5hKdR9raLzUviRx3oakyfcudCs/sLY880Drmktm46mrom1Nnmx1kVSx9+gvbOswump
        zd5cljfiJuWsX9n6juidVnzOklO5I/B73FWd+PSk3x6+mllvTv9PWib8a8WUQp+6+Yl81f/3
        WbgJeJlX/PKxuj6JJY1D+3WsqV7q5eWTbJVYijMSDbWYi4oTAcM433icAgAA
X-CMS-MailID: 20180322235315epcas1p495311f69a772ae252346cd5b6de77622
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180320125801epcas1p2117b4d90063e6c4129ec18e54b5bdea6
X-RootMTR: 20180320125801epcas1p2117b4d90063e6c4129ec18e54b5bdea6
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
        <CGME20180320125801epcas1p2117b4d90063e6c4129ec18e54b5bdea6@epcas1p2.samsung.com>
        <20180320125713.85465-13-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 03월 20일 21:57, Heikki Krogerus wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> The AXP288 BC1.2 charger detection / extcon code may seem like a strange
> place to add code to control the USB role-switch on devices with an AXP288,
> but there are 2 reasons to do this inside the axp288 extcon code:
> 
> 1) On many devices the USB role is controlled by ACPI AML code, but the AML
>    code only switches between the host and none roles, because of Windows
>    not really using device mode. To make device mode work we need to toggle
>    between the none/device roles based on Vbus presence, and the axp288
>    extcon gets interrupts on Vbus insertion / removal.
> 
> 2) In order for our BC1.2 charger detection to work properly the role
>    mux must be properly set to device mode before we do the detection.
> 
> Also note the Kconfig help-text / obsolete depends on USB_PHY which are
> remnants from older never upstreamed code also controlling the mux from
> the axp288 extcon code.
> 
> This commit also adds code to get notifications from the INT3496 extcon
> device, which is used on some devices to notify the kernel about id-pin
> changes instead of them being handled through AML code.
> 
> This fixes:
> -Device mode not working on most CHT devices with an AXP288
> -Host mode not working on devices with an INT3496 ACPI device
> -Charger-type misdetection (always SDP) on devices with an INT3496 when the
>  USB role (always) gets initialized as host
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes in v4:
> -Add Andy's Reviewed-by
> 
> Changes in v2:
> -Add depends on X86 to Kconfig (the AXP288 PMIC is only used on X86)
> -Use new acpi_dev_get_first_match_name() helper to get the INT3496 device-name
> -Add Heikki's Reviewed-by
> ---
>  drivers/extcon/Kconfig         |   3 +-
>  drivers/extcon/extcon-axp288.c | 176 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 170 insertions(+), 9 deletions(-)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
