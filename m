Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464EC2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPvatdIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfAaM2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:28:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33520 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:28:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so1415617pfb.0;
        Thu, 31 Jan 2019 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iW/h8MWbaF01RmdDZP0j9NWIvLzXRHN4Z1zyGuV1d6o=;
        b=vPvatdIkQdwXA+K9vkyjuWBbl02JR2/zZo8BKHKhPEdmJPgagwHrf2fHckT+0mtpCB
         UoebbNkE/kETF46WdzXP3qK4Y/pJ0QjeeJNrKUY7Ca9fSRH1JYeFFO8t1UZv0vJ4/kwC
         JM6PuzHHGsNdBXf/Gxl3Nqom19XbSdK064fjO7HX5a6x7r7vqlMZUs9N5FlKDIlokeJ/
         e2248GloO9YKJafGponj+stREHLvdFltuYscRsUAYvgFdMXB0SImPyXMofg/+hF87+6H
         LrCuOyoh0BmLjhAj4Yk2QZblNmsb77teSDRZvf/xTOBu4F6Q1CaaVF23fnZ7cKIsjkr5
         qI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iW/h8MWbaF01RmdDZP0j9NWIvLzXRHN4Z1zyGuV1d6o=;
        b=siHxmgrqWpeZoC7Q10rjjQTYFiBdRbU4zPpNoFOyae3LVezArDgI+8ho5zqKy/qc5a
         K0erXL85dTUmZRDLvbyurbTxn7wlwlYPD2csHcR3iDQOflDRsIrPpqOKhcWDBhvy5nDG
         VUVPE3gbnChQsj0PFC4ZSan73CJKjQcd4Ez/4oDbz9Ls2Tfughv8rHGm3b6dTwWjG4C1
         mCeHXfhSb4Dhp6NpNSMOTluqnwl6KxFRBYmcc8E1kk9860x1rgVWLHL0tEyaZmOExwdm
         e+/IsGJYGCS+Moy6VsDM71vV2NHQ1GMr5gaLTY+zKqIx9/cD8i3yRmEwX8i+YAIZ9nVf
         iQcg==
X-Gm-Message-State: AJcUuke1QZy+LBIQ9eK7ANhCRZnj6ADihweAnLefQRijoTzedtE+kOzH
        oUT+CtDFG/hZWIF080EpCcl/smXRQSKUQQdXNuo=
X-Google-Smtp-Source: ALg8bN61znq6VMVYG3+GP8mRVSqkr6YKterI51VsnyFruUiitol6x3JP/oP7lgeyrpclm9RiHJ7IGRFCmJnzdWTJS6I=
X-Received: by 2002:a62:5793:: with SMTP id i19mr34875351pfj.49.1548937682375;
 Thu, 31 Jan 2019 04:28:02 -0800 (PST)
MIME-Version: 1.0
References: <1548935553-452-1-git-send-email-pawell@cadence.com> <1548935553-452-5-git-send-email-pawell@cadence.com>
In-Reply-To: <1548935553-452-5-git-send-email-pawell@cadence.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 31 Jan 2019 14:27:50 +0200
Message-ID: <CAHp75Vd=rpOrVDhG=oALRPFtd-PCgPebQWv5zMKedZnT_9EKqw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] usb:common Simplify usb_decode_get_set_descriptor function.
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        USB <linux-usb@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, rogerq@ti.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jbergsagel@ti.com, Sekhar Nori <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>, peter.chen@nxp.com,
        pjez@cadence.com, kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 1:53 PM Pawel Laszczak <pawell@cadence.com> wrote:
>
> Patch moves switch responsible for decoding descriptor type
> outside snprintf. It's little improves code readability.

> +       char *s;

const ?

-- 
With Best Regards,
Andy Shevchenko
