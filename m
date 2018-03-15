Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCOMsx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:48:53 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45365 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeCOMsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:48:52 -0400
X-Google-Smtp-Source: AG47ELuOOq186Z2VQA6UJsbClgpCGz7LgRVOuH7COmZCgKoJDG5ZSik9hdXYIqfV9C04Su94MF7Grw==
Subject: Re: [PATCH v1 1/3] drm/tegra: plane: Fix RGB565 plane format on older
 Tegra's
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
 <20180315102700.GA15393@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <90169117-fc06-7d2d-34bd-af2827240048@gmail.com>
Date: Thu, 15 Mar 2018 15:48:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315102700.GA15393@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 13:27, Thierry Reding wrote:
> On Thu, Mar 15, 2018 at 04:00:23AM +0300, Dmitry Osipenko wrote:
>> Simplify opaque format adjustment by removing format checking. There are
>> only 4 formats that require the adjustment and so this way is less error
>> prone, avoiding mishandling native formats, like in this case RGB565 is
>> the format that was erroneously treated as invalid.
>>
>> Fixes: ebae8d07435a ("drm/tegra: dc: Implement legacy blending")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c    | 11 ++---------
>>  drivers/gpu/drm/tegra/plane.c | 21 ++++++---------------
>>  drivers/gpu/drm/tegra/plane.h |  2 +-
>>  3 files changed, 9 insertions(+), 25 deletions(-)
> 
> I've applied a slightly different version of this which doesn't rework
> as much of the surrounding code and is therefore easier to backport to
> v4.16.

Okay. Please don't forget to push the modified patch, I don't see it in the FDO git.
