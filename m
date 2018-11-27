Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0D0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A760208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mvdtw7Eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A760208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeK0R5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:57:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41968 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeK0R5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:57:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so19181940otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wl8sBScMZNM+xRd5P2NninIaWx8EbP/d9eQyxsxEsZ4=;
        b=mvdtw7EbLSCK9KvG2uL0l9Cc0k3nyyovNDbJgXTyxCvMp9efwL5774nVluQBC3dH2N
         YfV+k6DaLRTHbD4ouwtXpa/ygYER2g1i49pPLMVePBGOnMHfFZT6Tb/frFxZltoIWQFu
         DABBYRduyTk8CRH32O+hGsPU6Y55tz7rwQerEl+gN83VSOVv9AMeosiJvbj6zK5Ql7O+
         /+kuh1fKrpRsuyhtvUqCVNlftAjgt7sEP7TV22gS4LpO0BGZVVNNcs01v2N3t3wcI/Xi
         K8KlUe6TJb6j/4BBDkt3emLYGvEdnaFLDtRCPa4WmN/Uq4uMfeLuLI8E7XZreNozUii3
         v6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wl8sBScMZNM+xRd5P2NninIaWx8EbP/d9eQyxsxEsZ4=;
        b=gojU4iaZPx0OeJqC7fclNbQxZ6PpRvI40OzkDJl9ys0lhhx0rjnJQ02Do6mFKPcS9S
         1t3738IPOOpF3o+njoymGCB+LOOxAtVRnLZ9yYxJBG4rKd9rCYKyOZak1ICUNU/f1t29
         TRhnxUWZOneDRaTpxo+CBUyzdrrnQ7Pr6M6wJXyOdPLcMq9P4ZOOhU23gL06wzVE+62k
         WgL3yXtQhnJLOkunzPpqaZDu/IKmbgSkQfv43fbvHZVV5TzL711hFR64adn5YeJcp948
         c5horA479xgTiBKh7FPFysQtpxC6Ilgv+sLbrmQI52A9jC4FKbksKEVjOJpXFUx06k4L
         duDw==
X-Gm-Message-State: AA+aEWYCce+fO5dEbiVGnSOifuU0JbHcEvoHJnFYKVKBHr3aKZ12fxfL
        Ri6io5lhHAIEu4Bqp8es8xRH7itjFhKM5Egi7QG33Q==
X-Google-Smtp-Source: AJdET5dmkQsx4f/iw6e97KP3aFOAgRhAWLqCmVrM6mrh2PNL845KofjO83rF4MvvaUNlnwSerIVqTZmifENNRHNcHQ4=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr18037823otn.214.1543302019822;
 Mon, 26 Nov 2018 23:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20181114224921.12123-2-keith.busch@intel.com> <20181114224921.12123-3-keith.busch@intel.com>
In-Reply-To: <20181114224921.12123-3-keith.busch@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 23:00:09 -0800
Message-ID: <CAPcyv4jNpgzpfG1awrxspTeQ1JOK-4-Wu6Kb6cd6NGY6Atj3cg@mail.gmail.com>
Subject: Re: [PATCH 2/7] node: Add heterogenous memory performance
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 2:53 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Heterogeneous memory systems provide memory nodes with latency
> and bandwidth performance attributes that are different from other
> nodes. Create an interface for the kernel to register these attributes
> under the node that provides the memory. If the system provides this
> information, applications can query the node attributes when deciding
> which node to request memory.
>
> When multiple memory initiators exist, accessing the same memory target
> from each may not perform the same as the other. The highest performing
> initiator to a given target is considered to be a local initiator for
> that target. The kernel provides performance attributes only for the
> local initiators.
>
> The memory's compute node should be symlinked in sysfs as one of the
> node's initiators.
>
> The following example shows the new sysfs hierarchy for a node exporting
> performance attributes:
>
>   # tree /sys/devices/system/node/nodeY/initiator_access
>   /sys/devices/system/node/nodeY/initiator_access
>   |-- read_bandwidth
>   |-- read_latency
>   |-- write_bandwidth
>   `-- write_latency

With the expectation that there will be nodes that are initiator-only,
target-only, or both I think this interface should indicate that. The
1:1 "local" designation of HMAT should not be directly encoded in the
interface, it's just a shortcut for finding at least one initiator in
the set that can realize the advertised performance. At least if the
interface can enumerate the set of initiators then it becomes clear
whether sysfs can answer a performance enumeration question or if the
application needs to consult an interface with specific knowledge of a
given initiator-target pairing.

It seems a precursor to these patches is arranges for offline node
devices to be created for the ACPI proximity domains that are
offline-by default for reserved memory ranges.
