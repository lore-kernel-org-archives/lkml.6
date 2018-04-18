Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeDRLJ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:09:26 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:44413 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeDRLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:09:25 -0400
X-Google-Smtp-Source: AIpwx49krZiYAEKm6zAp0tCtQ9V1bdxMCEWB9OmNf9wLzFnZ9xnSH4uDNZ+EACy7i/pxWwv1k0w+UwwO3+OivP5XnwQ=
MIME-Version: 1.0
In-Reply-To: <20180418082439.GA4646@ulmo>
References: <20180417134755.GA30291@jordon-HP-15-Notebook-PC> <20180418082439.GA4646@ulmo>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 18 Apr 2018 16:39:22 +0530
Message-ID: <CAFqt6zb74=222mOnpnzLpfXEpttHTgpMitB-TgwrLdHKP3dEkg@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: tegra: Adding new typedef vm_fault_t
To: Thierry Reding <thierry.reding@gmail.com>
Cc: airlied@linux.ie, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This new function returns VM_FAULT_NOPAGE only for 0 and -EBUSY, whereas
> we used to return VM_FAULT_NOPAGE for -EAGAIN, -ERESTARTSYS and -EINTR
> as well.

Previously vm_insert_page unable to return VM_FAULT_ type due to which
different drivers
have their own mapping from err to VM_FAULT_ type. With new
vmf_insert_page() introduce
in 4.17-rc1 we have a common mapping for err to VM_FAULT_ which remain
same for every
drivers/file systems.

Was this previously wrong?

I think Matthew is the right person to answer this.
