Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8507C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFFE2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFFE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeITNTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:19:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39269 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeITNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:19:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id c12-v6so8461267otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFmf+QAM6flp/n2FMTqvfiqvvbSYVoY3DlFHVHUJva4=;
        b=TtvptXa+J+pWiCtORhKYKOZq2fgpHF84525dp5/8PtrWheoKXYj7tg1Dq6gXE3zEWy
         YCFoeVzkMfyCOAzeQEkpywMGYrVT8NTlc4/HPnb+T2+r5yGgnSq6gIqN5VMPwrT29vKk
         Qjvtu4HFKM7UokF8WnZ4ahh/zFE8yr3kU/bte2eoaQI5xqR+n0UFvXxrfZKs7xKktMzi
         7WYMFufgUEh5WQPhtUk5AWCfUz3mwSmaB7EHfym+iQftLFLYDLZl70e6HgBqHaF5vvMR
         zA1n206rMgyagIBYxjnxF8VPwJXPPblZV05nCQPY7qvKolMsTuWh1VMLLxGlP03k0TPu
         THCQ==
X-Gm-Message-State: APzg51C60NmPttzkpDrrzjP3xQ5sBY2hGaD6Kos+7Ih1ODCdTsPjwGFa
        lRHHRv3Xk1wDyYznviQQSfPF2K1UAkPNUdWrzkg=
X-Google-Smtp-Source: ANB0VdZNp206xYX+V5D3lLAdQ75a/N87AsoRXOhQdIKcdQRGzgLt+ITGEy3OYqdGx2Ojh1c/KM8SOIqiNhjkK6B5+qE=
X-Received: by 2002:a9d:2645:: with SMTP id a63-v6mr20519075otb.270.1537429018086;
 Thu, 20 Sep 2018 00:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <1537422122-6166-1-git-send-email-svellattu@mvista.com>
In-Reply-To: <1537422122-6166-1-git-send-email-svellattu@mvista.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Sep 2018 09:36:46 +0200
Message-ID: <CAJZ5v0j05v+69cCJ1jzekdC_2kqXu6SQaNLeOhk=04b08pT6YQ@mail.gmail.com>
Subject: Re: [PATCH] Driver core: add bus_find_device_by_of_node
To:     svellattu@mvista.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 7:43 AM Silesh C V <svellattu@mvista.com> wrote:
>
> Similar to bus_find_device_by_name, but finds the device having a
> specific of_node.

First, what do you need it for?  Please describe your use case in the changelog.

Second, what about a more generic bus_find_device_by_fwnode() ?

Thanks,
Rafael
