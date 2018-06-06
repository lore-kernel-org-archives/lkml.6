Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/MaYM4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 056F1601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeFFIlL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:41:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35366 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeFFIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:41:09 -0400
X-Google-Smtp-Source: ADUXVKKyK0aenMoilSWlHx9VkF0X7yr4QKZHXl3Y5HG5+Z/V11E8Omu5a2gcnMWfe/IDMW9PaFORmA==
Date: Wed, 6 Jun 2018 04:41:05 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Li Wang <liwang@redhat.com>
Cc: Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com,
        snitzer@redhat.com, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Block IO issue in kernel-v4.17
Message-ID: <20180606084105.GA10720@kmo-pixel>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 04:37:25PM +0800, Li Wang wrote:
> Hi BIO experts,
> 
> I catch this panic issue on some kind of arches(x86_64, ppc64,
> ppc64le..), it seems the root cause is very probably from BIO changes
> from kernel-4.17-rc7. Plz take a look.

That's the bioset changes, the fix is out and on its way in
