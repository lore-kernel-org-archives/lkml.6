Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCZMnv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:43:51 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63711 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751024AbeCZMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:43:50 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Ben Skeggs <bskeggs@redhat.com>,
        "Arushi Singhal" <arushisinghal19971997@gmail.com>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CABDvA=nFq6nPMyhB3C87XxVkxXwy23NQVES2Na_TVB6VreKrrQ@mail.gmail.com>
Cc: "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        "dri-devel" <dri-devel@lists.freedesktop.org>,
        "nouveau" <nouveau@lists.freedesktop.org>, daniel.vetter@intel.com
References: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
 <1522000893-5331-3-git-send-email-arushisinghal19971997@gmail.com>
 <CABDvA=nFq6nPMyhB3C87XxVkxXwy23NQVES2Na_TVB6VreKrrQ@mail.gmail.com>
Message-ID: <152206821005.4115.12768359647232399397@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH v2 2/2] gpu: drm: nouveau: Use list_{next/prev}_entry instead of
 list_entry
Date: Mon, 26 Mar 2018 13:43:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ben Skeggs (2018-03-26 13:34:54)
> On Mon, Mar 26, 2018 at 4:01 AM, Arushi Singhal
> <arushisinghal19971997@gmail.com> wrote:
> > It's better to use list_entry instead of list_{next/prev}_entry
> > as it makes the code more clear to read.
> > This patch replace list_entry with list_{next/prev}_entry.
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> Acked-by: Ben Skeggs <bskeggs@redhat.com>
> 
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > index e4c8d31..81c3567 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> > @@ -134,7 +134,7 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct nvkm_pstate *pstate,
> >                                nvkm_volt_map(volt, volt->max2_id, clk->temp));
> >
> >         for (cstate = start; &cstate->head != &pstate->list;
> > -            cstate = list_entry(cstate->head.prev, typeof(*cstate), head)) {
> > +            cstate = list_prev_entry(cstate, head)) {

This loop could be written as:

	cstate = start; /* cstate looks redundant here, just use start? */
	list_for_each_entry_from_reverse(cstate, &pstate->list, head)

> >                 if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
> >                         break;
> >         }
> > --
> > 2.7.4
