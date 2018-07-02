Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D05AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BE025333
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc/Lu9UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BE025333
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbeGBJGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:06:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46778 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeGBJGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:06:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so14974968oie.13;
        Mon, 02 Jul 2018 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0WV5yKlSgdiZDxuC0JtM34KjQMNT2FcfEiT9EIyR6QI=;
        b=mc/Lu9UGMNEJioh+jKVQlC2iejVehzXA/31/xtXFAn/R5JhZlv3Xll3IOpzaWjEdsO
         o+m+L3UBGEbvGmzLLon2ietezvMPAR+Nzz7dUuXdbf6T5L1+HgoYXIcRF6dq59hPuzb9
         hee9nsQM+vM0IUYel6jkEPzxKbJ2NgmM+yM9Ca3H9ez8RMEEXm14TvCd2ZACQcUkLTqv
         1GLgXbIB7WimAGzUS2SACcuck/nUSyZVRpALTcXRZsQknNTL78/S8nCNPUGJ7JYgf+dn
         ZdfsK7h4T0BB5SfcIHQwL2QXLVJBcxjJI/75Qq+Jsjp7+3dNDvxSn3ToqodSufPc20Ja
         e0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0WV5yKlSgdiZDxuC0JtM34KjQMNT2FcfEiT9EIyR6QI=;
        b=KU316VpaWAed3RUgj58a/A7AQ3byC8XRhYrtz0fsMIYS1QcwpgZQ/ENVTYxGvXExXi
         y+dAMxO82w0b886BMeyWIMrGYYT8+ksWxxKZwkEk9Ajri8Zy/fQ1ddMGzVZMxMjt4UW3
         ka31gNMuMz9RATVguZp67JnynhvJLWfbnve6jTuyjq+rZPdVC9eeR2Yjb2LhKsuLYQgf
         2w1TWxkhmTOTiVXUSx2lGqpRQaHL5o/2J0JeMdDHQ+JQ3Ed2Hnrdnvf0IwmVZczricoM
         N9N1sbGpubEOXB9cGWqy6DTKpXD0XDlCspID6iBebGgrL1UnU+qHPT0Q5inw3xK4kRuH
         9M8Q==
X-Gm-Message-State: APt69E0/Hc52llAO0WfMa8snGfBUxEZASt2mwrC+VMHGx1Xe9+xiMi8Y
        3s1/h2TByI7e2i0S7HnU9sexIVfSk2zdFNCpA2Y=
X-Google-Smtp-Source: AAOMgpdkUOOv/3zNsz3FjOTw1tMItNeN+/HTgbVGnrrEDG1glMCSJVJo7POg9+oN4lD5wZWnTFhbLuxlDfyEW7fJ03w=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr7420940oib.116.1530522382808;
 Mon, 02 Jul 2018 02:06:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 02:06:22 -0700 (PDT)
In-Reply-To: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Jul 2018 11:06:22 +0200
X-Google-Sender-Auth: Fu65Zn6-AlL7CfCjDeobe7-fSpc
Message-ID: <CAJZ5v0gnspK3soa5j8iqU9QDM78MMBbz8YC9s7TOJ5Qwh7=mZg@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
 is set
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 6:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Currently we use the ACPI processor ID only for the leaf/processor nodes
> as the specification states it must match the value of ACPI processor ID
> field in the processor=E2=80=99s entry in the MADT.
>
> However, if a PPTT structure represents processors group, it match a
> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_=
VALID
> flag describe whether the ACPI processor ID is valid.
>
> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
> consistent instead of using table offset as it's currently done for non
> leaf nodes.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Hi,
>
> There's ongoing discussion on assigning ID based in OS using simple
> counters. It can never be consistent with firmware's view. So if the
> firmware provides valid UID for non-processors node, we must use it.

OK

Do you regard this as a fix for the recently merged PPTT material?  If
so, I should apply it as a fix for 4.18.

Thanks,
Rafael
