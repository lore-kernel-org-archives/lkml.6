Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCZMe5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:34:57 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42775 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:34:56 -0400
X-Google-Smtp-Source: AIpwx49YzTGHYUSmF0ZAYf3cpAeQKbLYTM1bmbKRTwodXRg+WggcImS3domjKHBxu0Bn6mhgfI+SBAbojSTQj9ZPuHU=
MIME-Version: 1.0
In-Reply-To: <1522000893-5331-3-git-send-email-arushisinghal19971997@gmail.com>
References: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com> <1522000893-5331-3-git-send-email-arushisinghal19971997@gmail.com>
From: Ben Skeggs <bskeggs@redhat.com>
Date: Mon, 26 Mar 2018 22:34:54 +1000
Message-ID: <CABDvA=nFq6nPMyhB3C87XxVkxXwy23NQVES2Na_TVB6VreKrrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpu: drm: nouveau: Use list_{next/prev}_entry
 instead of list_entry
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, seanpaul@chromium.org,
        gustavo@padovan.org, daniel.vetter@intel.com,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 4:01 AM, Arushi Singhal
<arushisinghal19971997@gmail.com> wrote:
> It's better to use list_entry instead of list_{next/prev}_entry
> as it makes the code more clear to read.
> This patch replace list_entry with list_{next/prev}_entry.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index e4c8d31..81c3567 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
>                                nvkm_volt_map(volt, volt->max2_id, clk->temp));
>
>         for (cstate = start; &cstate->head != &pstate->list;
> -            cstate = list_entry(cstate->head.prev, typeof(*cstate), head)) {
> +            cstate = list_prev_entry(cstate, head)) {
>                 if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
>                         break;
>         }
> --
> 2.7.4
>
