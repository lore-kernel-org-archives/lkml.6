Return-Path: <matt.ranostay@konsulko.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519797493; cv=none;
        d=google.com; s=arc-20160816;
        b=PLgA8+wDbdMEa7uAv6SXbGsjQWsBEBmD6UFAb73+i+ULDwQC/niuRJrXhR1qAQGmt5
         50nBigBAkiDCpo4tfbAnUokIbt0+lusY4DYhM2TsOuEyrvI8rp5GQnMfXoGFuSiGfrkg
         a6bDYNzcPzbrHnT7GTFDLNHl+KGfkUrH6XY74ypGuBH6MzzJkzrn5w7S22wSVWsthbEA
         zJzSXukS0Cydw4KMVcdEI2meuO0llk/WSq5Oqd25WLIshQ+EFYajh49hxcDiSm39SmtN
         HNsIGrnZWVP00mOXezVeKrzJc6J3sJhAY9SgD+BCVmMlkSOJqZLHX+Hag+E9RcLCxohD
         ePmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eZs7uNQBLIiHmQwmEbU0kfXkqxS+uZjSr9x0NHQtcAI=;
        b=sShIRwkcSY707izibd9fa9040XL+S5JO4w1cUO5wyI4PL9gIyyYZqjUrsmaoZZ/I9f
         EsHjqW++nLiy4dPm3h6k6gTiPryH+3yz2STX3N8chlLdu04zl9+F0NjOUpRaRlPwGpgz
         cfLjf0kzr5lTbLsZYYYcWmYdMgcH/mbkyuQN0VrXu2LY8PTM2ukI1pL4sSHudZHuXvZb
         SB/Cyh0hccZ3BnwwfM5oG57GlooYwju9x2csZpiiGe9iMNiQXFOomT4PAu6x1S5B+zqA
         gaJz8M0OJKu88kadlNSm+DbY0R9KgNI7xhn+LjrWjNNO8Z36MkDOh9DqJsPntp5MkJ7J
         Ue0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@konsulko.com header.s=google header.b=blNv3wLw;
       spf=pass (google.com: domain of matt.ranostay@konsulko.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=matt.ranostay@konsulko.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@konsulko.com header.s=google header.b=blNv3wLw;
       spf=pass (google.com: domain of matt.ranostay@konsulko.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=matt.ranostay@konsulko.com
X-Google-Smtp-Source: AG47ELt5y8xTdzxGqwZh7VmMiIhKrWo6Lbw05oR8qu3KA0P1MwirmfWMRz340Lpn8fTbt4P00633NKkMmRoPN7k9XmI=
MIME-Version: 1.0
In-Reply-To: <20180228010452.1713-2-merlijn@wizzup.org>
References: <20180228010452.1713-1-merlijn@wizzup.org> <20180228010452.1713-2-merlijn@wizzup.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Tue, 27 Feb 2018 21:58:12 -0800
Message-ID: <CAJCx=gk5vw1R3HuxVdrKxHW9EY7hc01RDrhCxNWTeiT8TtpTHA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] power: supply: bq27xxx: Call power_supply_changed
 on status change
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: linux-omap@vger.kernel.org, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593604801076921688?=
X-GMAIL-MSGID: =?utf-8?q?1593623175990598388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit message please :)

On Tue, Feb 27, 2018 at 5:04 PM, Merlijn Wajer <merlijn@wizzup.org> wrote:
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---

Single patch changes usually don't have a cover letter. you put more
detail here in the cutoff section (aka after --- above)


>  drivers/power/supply/bq27xxx_battery.c | 59 +++++++++++++++++-----------------
>  include/linux/power/bq27xxx_battery.h  |  1 +
>  2 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 0a203672744c..218d153fb431 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1527,6 +1527,31 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>         return POWER_SUPPLY_HEALTH_GOOD;
>  }
>
> +static int bq27xxx_battery_read_status(struct bq27xxx_device_info *di)
> +{
> +       int status;
> +
> +       if (di->opts & BQ27XXX_O_ZERO) {
> +               if (di->cache.flags & BQ27000_FLAG_FC)
> +                       status = POWER_SUPPLY_STATUS_FULL;
> +               else if (di->cache.flags & BQ27000_FLAG_CHGS)
> +                       status = POWER_SUPPLY_STATUS_CHARGING;
> +               else if (power_supply_am_i_supplied(di->bat) > 0)
> +                       status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               else
> +                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> +       } else {
> +               if (di->cache.flags & BQ27XXX_FLAG_FC)
> +                       status = POWER_SUPPLY_STATUS_FULL;
> +               else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> +                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> +               else
> +                       status = POWER_SUPPLY_STATUS_CHARGING;
> +       }
> +
> +       return status;
> +}
> +
>  void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  {
>         struct bq27xxx_reg_cache cache = {0, };
> @@ -1547,6 +1572,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>                         cache.time_to_full = -ENODATA;
>                         cache.charge_full = -ENODATA;
>                         cache.health = -ENODATA;
> +                       cache.status = bq27xxx_battery_read_status(di);
>                 } else {
>                         if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
>                                 cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
> @@ -1559,6 +1585,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>                         if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
>                                 cache.energy = bq27xxx_battery_read_energy(di);
>                         cache.health = bq27xxx_battery_read_health(di);
> +                       cache.status = bq27xxx_battery_read_status(di);
>                 }
>                 if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
>                         cache.cycle_count = bq27xxx_battery_read_cyct(di);
> @@ -1570,7 +1597,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>                         di->charge_design_full = bq27xxx_battery_read_dcap(di);
>         }
>
> -       if (di->cache.capacity != cache.capacity)
> +       if ((di->cache.capacity != cache.capacity) || (di->cache.status != cache.status))
>                 power_supply_changed(di->bat);
>
>         if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
> @@ -1625,34 +1652,6 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
>         return 0;
>  }
>
> -static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
> -                                 union power_supply_propval *val)
> -{
> -       int status;
> -
> -       if (di->opts & BQ27XXX_O_ZERO) {
> -               if (di->cache.flags & BQ27000_FLAG_FC)
> -                       status = POWER_SUPPLY_STATUS_FULL;
> -               else if (di->cache.flags & BQ27000_FLAG_CHGS)
> -                       status = POWER_SUPPLY_STATUS_CHARGING;
> -               else if (power_supply_am_i_supplied(di->bat) > 0)
> -                       status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> -               else
> -                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> -       } else {
> -               if (di->cache.flags & BQ27XXX_FLAG_FC)
> -                       status = POWER_SUPPLY_STATUS_FULL;
> -               else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> -                       status = POWER_SUPPLY_STATUS_DISCHARGING;
> -               else
> -                       status = POWER_SUPPLY_STATUS_CHARGING;
> -       }
> -
> -       val->intval = status;
> -
> -       return 0;
> -}
> -
>  static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
>                                           union power_supply_propval *val)
>  {
> @@ -1733,7 +1732,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_STATUS:
> -               ret = bq27xxx_battery_status(di, val);
> +               ret = bq27xxx_simple_value(di->cache.status, val);
>                 break;
>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>                 ret = bq27xxx_battery_voltage(di, val);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index e6187f524f2c..4f27656045fd 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -49,6 +49,7 @@ struct bq27xxx_reg_cache {
>         int flags;
>         int power_avg;
>         int health;
> +       int status;
>  };
>
>  struct bq27xxx_device_info {
> --
> 2.16.2
>
