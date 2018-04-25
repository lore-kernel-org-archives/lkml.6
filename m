Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeDYG3x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:29:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36956 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeDYG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:29:48 -0400
X-Google-Smtp-Source: AIpwx4/4Q5ZjxE9oRQPMMbo54zAUrwqjzH8/b/M/338oj5+vOEnsnmEmERyjIIRC8u8EGI4IwSxwFkeLfTezo06VgnY=
MIME-Version: 1.0
In-Reply-To: <20180424131536.2611-1-luc.vanoostenryck@gmail.com>
References: <20180424131536.2611-1-luc.vanoostenryck@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Apr 2018 02:29:46 -0400
Message-ID: <CADnq5_OM3Uvq2vNXdnHGDLWj6e58k7+rm2iaVKNMDsC0_7Ejxg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_atpx_get_client_id()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 9:15 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The method struct vga_switcheroo_handler::get_client_id() is defined
> as returning an 'enum vga_switcheroo_client_id' but the implementation
> in this driver, amdgpu_atpx_get_client_id(), returns an 'int'.
>
> Fix this by returning 'enum vga_switcheroo_client_id' in this driver too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Applied the whole set for radeon and amdgpu.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index 1ae5ae8c4..1bcb2b247 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -550,7 +550,7 @@ static int amdgpu_atpx_init(void)
>   * look up whether we are the integrated or discrete GPU (all asics).
>   * Returns the client id.
>   */
> -static int amdgpu_atpx_get_client_id(struct pci_dev *pdev)
> +static enum vga_switcheroo_client_id amdgpu_atpx_get_client_id(struct pci_dev *pdev)
>  {
>         if (amdgpu_atpx_priv.dhandle == ACPI_HANDLE(&pdev->dev))
>                 return VGA_SWITCHEROO_IGD;
> --
> 2.17.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
