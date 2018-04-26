Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1950236-1524722030-2-9746384013639905849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org', XOriginatingCountry='VN'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524722029; b=W6A438T5w8+qo2Ce0wrKeGizfCRVzpl/v+rQOLMEgN26WYWStp
    b4kOxl9R9xmBpuJGbvO85LqiIrSxnKBMPmt17q56JaLlaqMkyLL4C1oM97TVVtNG
    mpJkep1ygzU+V4WhL8joj280Cl3VkNxkR78kCpfXQmHfT4ILfk5Xn+ltFLag7Or8
    Wll4Pkgvy8+hszI9xYtw+nIHkqOI46xUDnRk9lXdZAPW2aNeroA673SVVErkSQfE
    5FbCKWiwgS9gau2y286rsaxFoHSca8xtM6G9wq/lNHOR/9S//+lbeSofOSqGpdYH
    fTj+2jshy70CLP2hZ6oLqYbQ+YO+TuWzyJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1524722029; bh=p
    UQpHeYIbn3iurDv+svm8cT1kmfZT3uKf8j2csLMkrM=; b=OdbTWoZA7p1jOYebi
    qYt7WbWBFQiGzhGJkGF74ZgbCO7eU69Gwnbj82/GDL8EOMvEyrd0I29AjameV0b2
    mqiaxnyDlVMx9pMUU1XhxE162oxqc+xvoRXWGO1Z/bfPqvCxLv8GOKKWYkIPGwVm
    W19NN9sLciiAC3EnaargbCMdwUpHnnEgPvv48AIravdQmAQda3huEjxUfKKIZlS8
    aRZGfdv0H1Xptjy6qlvRVRBNFKORBeoM9C994VA2HDwOa3EOztQVely3TOxWH8Oi
    LIEanOC/sc6KtW7fyW4IC3kpyJ4p5H0haoZduucglC+H/3F/CKpok2G4s9jcwOeM
    FMdUg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=etezian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=etezian.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=etezian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=etezian.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDUJxNljUayp+0h+HRr5dfMBieidGstH5ygpjjytdHqHF4byCTlzB661NtZwn3BXer4cCzVrugvRg0LkGSMjgalh/EIf/mKu+zyDjc81ycWRD25R9qz9
    wTDV7SjO9/bMmfPQqVKIFpFlMzfY9s014+p4MrKBZRaswB/0Y5q3UuGYsw1ujbs4Rv/SgpDsVlXihBI71Rp7OCxOwpbgSZA6wb4KkYzgzbrOCuHi0NoR3G5w
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=qpKAz7QdKFQA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=gx6koJuJAAAA:8 a=bFUnhJpB9Z3-8uSK8OwA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=td0oL5riYOtXiimfbIXQ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeDZFxq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 01:53:46 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:34367 "EHLO
        7.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeDZFxn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 26 Apr 2018 01:53:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Apr 2018 13:35:03 +0900
From: andi@etezian.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 08/10] spi: s3c64xx: samsung: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-9-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-9-krzk@kernel.org>
Message-ID: <f47ea49afb9301d33383143056ed11a7@etezian.org>
User-Agent: Roundcube Webmail/1.3.6
X-Originating-IP: 113.161.58.156
X-Webmail-UserID: andi@etezian.org
X-Ovh-Tracer-Id: 6277173457592763033
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtgedrledvgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Krzysztof,

On 25.04.2018 05:32, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
