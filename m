Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755650AbeEHURI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 16:17:08 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:41194 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754622AbeEHURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 16:17:06 -0400
X-Google-Smtp-Source: AB8JxZq88l2XpgU0ze4m+0GMoicGvR1MWlnLakqt29SeqRr90n9lUgohIF/HZSYR96w41HDGlUthQ3S5yRzP8Z3qDdU=
MIME-Version: 1.0
In-Reply-To: <20180508030811.12256-1-baijiaju1990@gmail.com>
References: <20180508030811.12256-1-baijiaju1990@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 May 2018 22:17:04 +0200
X-Google-Sender-Auth: eDMOOq3duh27M9QiJnNBGw8JNYA
Message-ID: <CAJZ5v0jqW0yuSOSrgy1=dWARPHmaxtG4fvkZj=pX+fPcTTJh1A@mail.gmail.com>
Subject: Re: [PATCH] acpi: scan: Fix a possible data race in acpi_scan_hotplug_enabled
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 5:08 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> The write operation to "hotplug->enabled" is protected by
> the lock on line 1760, but the read operation to
> this data on line 1755 is not protected by the lock.
> Thus, there may exist a data race for "hotplug->enabled".

Either it does exist, or it doesn't.

If it exists, it needs to be fixed.  If it doesn't exist, nothing
needs to be done.

Which is the case?
