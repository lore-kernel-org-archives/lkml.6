Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFEMmp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:42:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37711 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeFEMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:42:43 -0400
X-Google-Smtp-Source: ADUXVKJk8dBzke6m3ySa7qAJs8H3XaIklh7k4qmefP0eb/q8fu+CZkSTe1zNAUEdFRA5B/Epf+/iBQ==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
From: Ilya Matveychikov <matvejchikov@gmail.com>
In-Reply-To: <20180605122829.y4vicefcfvzpqraw@twin.jikos.cz>
Date: Tue, 5 Jun 2018 16:42:38 +0400
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Message-Id: <707FB500-5592-45B8-9279-36BE74CDBBCE@gmail.com>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <20180605112641.GN30522@ZenIV.linux.org.uk>
 <1E519BA2-4198-4255-BAE4-3125C59741A3@gmail.com>
 <20180605115340.GO30522@ZenIV.linux.org.uk>
 <0F38EDA5-DEC3-48A1-9375-47949C26DAE8@gmail.com>
 <20180605122829.y4vicefcfvzpqraw@twin.jikos.cz>
To: dsterba@suse.cz
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55Cgodf008599


> On Jun 5, 2018, at 4:28 PM, David Sterba <dsterba@suse.cz> wrote:
> 
>> BTW, sys_umount() has this check in the right place - before doing anything.
>> So, why not to have the same logic for mount/umount?
> 
> What if the check is not equivalent to the one done later? may_mount
> needs namespace, it will be available at umount time but not necessarily
> during mount due to the security hooks.

Might be the issue, you’re right. I can’t tell it for sure as I’m not so
familiar with linux/fs code.
