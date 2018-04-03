Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932177AbeDCMjT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:39:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42288 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeDCMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:39:14 -0400
X-Google-Smtp-Source: AIpwx4/bz6k916NVCSZL8oPZG2bh29NTdVBPAi9rq9BuLBMaM0rsCvNa3QeT/oNPM30NpFfMgYDLvQ==
Date: Tue, 3 Apr 2018 05:39:10 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] phy: tegra: Remove self cast in
 tegra_xusb_port_find_lane
Message-ID: <20180403123910.GA13077@flashbox>
References: <20180401110410.GA3405@flashbox>
 <20180403104916.GC27789@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403104916.GC27789@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 12:49:16PM +0200, Thierry Reding wrote:
> On Sun, Apr 01, 2018 at 04:04:10AM -0700, Nathan Chancellor wrote:
> > Clang warns about casting variables to themselves because it is rarely
> > necessary. Removing the cast should not change anything regarding the
> > code and silences the warning.
> > 
> > ../drivers/phy/tegra/xusb.c:421:11: warning: explicitly assigning value
> > of variable of type 'const struct tegra_xusb_lane_map *' to itself
> > [-Wself-assign]
> >         for (map = map; map->type; map++) {
> >              ~~~ ^ ~~~
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > I am not entirely sure if this is the correct solution, especially since
> > I don't have the hardware and I am not too familiar with this code. If
> > there is a better solution, please let me know.
> > 
> > Changes from v1 -> v2: Fix spelling error in commit title
> > 
> >  drivers/phy/tegra/xusb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> > index 63e916d4d069..11aa5902a9ac 100644
> > --- a/drivers/phy/tegra/xusb.c
> > +++ b/drivers/phy/tegra/xusb.c
> > @@ -418,7 +418,7 @@ tegra_xusb_port_find_lane(struct tegra_xusb_port *port,
> >  {
> >  	struct tegra_xusb_lane *lane, *match = ERR_PTR(-ENODEV);
> >  
> > -	for (map = map; map->type; map++) {
> > +	for (; map->type; map++) {
> >  		if (port->index != map->port)
> >  			continue;
> >  
> 
> An equivalent patch seems to already have been merged. See:
> 
> 	https://patchwork.kernel.org/patch/10072641/
> 
> You can avoid duplication of effort such as this by basing any patches
> you send on top of a recent linux-next. The above patch, for example,
> was added in next-20180223.
> 
> Thanks,
> Thierry

Hi Thierry,

Thanks for the response. My apologies for not basing on linux-next; I
thought I did a cursory glance at both the phy and tegra trees but
apparently I didn't do it close enough. Definitely won't make the same
mistake again.

Cheers!
Nathan
