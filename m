Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79617C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387BC2687A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387BC2687A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeF1EM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:12:29 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:44041 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbeF1EM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:12:27 -0400
Received: by mail-qt0-f180.google.com with SMTP id 92-v6so3613169qta.11;
        Wed, 27 Jun 2018 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wBMyEArjaVNzZAe9wNYG3G97pFpmCcAlOcFVFn6bA7s=;
        b=JADmYlH9t8Ysj0QsKzwxF17aUKVG0CFPIynVPKWaXIE8aZ/fEz/Twr28LSb19uEeEX
         PwR+Cns9lJODknSuHF8tAaMIhY3Xj2D7oLF60EzzjVBSBUj2qobRUrw4XssNitIiqWOV
         zr7WnMW2HbtLrEotwIfZEaRdR36/82Cys2H2FiDRebCe0Ya5HghyDVWKI6p7zIHBmTcl
         thrayZpQdFR0N8QcEFeBf4c6m165obN3rk/uQ6H+r50IAAkGxxHp2amnPOTmpLA7Jf0C
         gvfknzH8qUSFFCb17vw0pbRi8wsv2tooM8pDB8taNGEuVI53Q1gDPUutoiPxtjlwfumz
         2XCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wBMyEArjaVNzZAe9wNYG3G97pFpmCcAlOcFVFn6bA7s=;
        b=Sd1+gB1XsYktVkbt2wYPJZ5v287/swToyA2uZNtAaorDiNRXUQxerOyy94rvRLpAWS
         kN8R5OQ5ImzDzXqOWmqgKzrYS6NHUXa0kQMJxrEqGrHN05VpW9N5qOU7g+gSLlMla4tp
         +weUt2zTB3pMocPbRPqmrikYzBKCEzaWu0sws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wBMyEArjaVNzZAe9wNYG3G97pFpmCcAlOcFVFn6bA7s=;
        b=FuZUnl7trOnYVV4mbbnEqQNC0Hw3Z1x8/m3ng11aA6iukeb4DFAGeAdZEoGGvycBms
         4er4mkL8T8lDHcFtYRoZHJtFZ347+eyGEwqZb0X7fJECV5qoFMC/YOwEY988/gD1tjsJ
         4lySGUFLcwe6x8qOk3s1Vte1I0zGXP0uEZihArn3ntbPsjWl2XinTL+/B5OcsOIWtWFu
         X4MwGQDKK2YNaNiaUFedRvZQjFz8dkB1JSdR7s13Li/ho0aWvtV9jWJFWuo+f7dghgjy
         XWtG+mhuf8KwyaRriBhvXyf/3PLYVmEYiFl3F2PPruvYirGoRoDrYmUXbeum+SkMaO5B
         pZ0g==
X-Gm-Message-State: APt69E3VMsR35m5kbqhJJ4vvVWpXgrW5nCZLo/bROJ7CGJzaIg8kZAzN
        Y59WU4ieTwRGmx3p0DHMRu5rWlnubHq4SYjlYkloTg==
X-Google-Smtp-Source: AAOMgpdL7QmRyCkIFLWY440UQKWF6FnmPn6JJnyt7zNimwWgruxfkpkSo9+SUwm1NLMxR+cXg0S1HowxaHiBhuQRI5w=
X-Received: by 2002:a0c:a943:: with SMTP id z3-v6mr7766738qva.208.1530159146177;
 Wed, 27 Jun 2018 21:12:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:12:05
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-10-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-10-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:42:05 +0930
X-Google-Sender-Auth: XQY3RutJhIjSRLfSBJQsBlhc9ew
Message-ID: <CACPK8Xf0AKAgwH7JBcRNg=2jbW4Q+5XgGOkn1AHBf4X-3ASZfA@mail.gmail.com>
Subject: Re: [PATCH 09/14] fsi: master-gpio: Add missing release function
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The embedded struct device needs a release function to be
> able to successfully remove the driver.
>
> We remove the devm_gpiod_put() as they are unnecessary
> (the resources will be released automatically) and because
> fsi_master_unregister() will cause the master structure to
> be freed.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
