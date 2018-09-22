Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9AECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691C3208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691C3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIWBjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 21:39:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60783 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeIWBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 21:39:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7CDE680762; Sat, 22 Sep 2018 21:44:52 +0200 (CEST)
Date:   Sat, 22 Sep 2018 21:44:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180922194451.GA27826@amd>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
 <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com>
 <20180921211758.GC18062@amd>
 <ccac8e5f-e122-9f7d-aa43-fa89c79cb1fe@gmail.com>
 <20180921221813.GA20355@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20180921221813.GA20355@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2018-09-22 00:18:13, Pavel Machek wrote:
> On Sat 2018-09-22 00:11:29, Jacek Anaszewski wrote:
> > On 09/21/2018 11:17 PM, Pavel Machek wrote:
> > > On Fri 2018-09-21 22:59:40, Jacek Anaszewski wrote:
> > >> Hi Baolin,
> > >>
> > >> On 09/21/2018 05:31 AM, Baolin Wang wrote:
> > >>> Hi Jacek and Pavel,
> > >>>
> > >>> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org>=
 wrote:
> > >>>> This patch adds one new led trigger that LED device can configure
> > >>>> the software or hardware pattern and trigger it.
> > >>>>
> > >>>> Consumers can write 'pattern' file to enable the software pattern
> > >>>> which alters the brightness for the specified duration with one
> > >>>> software timer.
> > >>>>
> > >>>> Moreover consumers can write 'hw_pattern' file to enable the hardw=
are
> > >>>> pattern for some LED controllers which can autonomously control
> > >>>> brightness over time, according to some preprogrammed hardware
> > >>>> patterns.
> > >>>>
> > >>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
> > >>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > >=20
> > >>> Do you have any comments for the v12 patch set? Thanks.
> > >>
> > >> We will probably have to remove hw_pattern from ledtrig-pattern
> > >> since we are unable to come up with generic interface for it.
> > >> Unless thread [0] will end up with some brilliant ideas. So far
> > >> we're waiting for Pavel's reply.
> > >>
> > >> [0] https://lkml.org/lkml/2018/9/13/1216
> > >=20
> > > To paint a picture:
> > >=20
> > > brightness
> > >=20
> > >    rise hold          lower       hold down
> > >   ^    XXXXXXXXXXXXXXX
> > >   |   X               XX
> > >   |  X                  XX
> > >   | X                     XXXXXXXXXXXXXXXXXXXXXXXXXX
> > >   +-------------------------------------------------------> time
> > >=20
> > > This is what Baolin's hardware can do, right?
> > >=20
> > > This is also what pattern trigger can do, right?
> > >=20
> > > So all we need to do is match the two interfaces, so that hw_pattern
> > > returns -EINVAL on patterns hardware can not actually do.
> > >=20
> > > I believe I described code to do that in [0] above.
> >=20
> > You said that we should get the same effect by writing the
> > same series of tuples to either pattern or hw_pattern file.
> >=20
> > Below command consists of four tuples (marked with brackets
> > to highlight), and it will activate breathing mode in Baolin's
> > hw_pattern:
> >=20
> > "[0 rise_duration] [brightness high_duration] [brightness fall_duration]
> > [0   low_duration]"
> >=20
> > Now, I can't see how these four tuples could force the software
> > fallback to produce breathing effect you depicted.
>=20
> I really should get some sleep now. But my intention was that software
> fallback produces just that with those four tuples. (If it does not,
> we can fix the software fallback to do just that).

And you are right, v12 1/2 seems to do the wrong thing.

My "brilliant idea" is to something closer to the original version I
posted here. I'm attaching it for reference.

I'm also attaching the original documentation. It was clearly designed
to do smooth transitions, too. (But pattern is written in slightly
different way there, AFAICT).

Clearly, having same semantics for pattern and hw_pattern is possible.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gBBFr7Ir9EOA20Yy
Content-Type: text/x-csrc; charset=iso-8859-1
Content-Disposition: attachment; filename="ledtrig-pattern.c"
Content-Transfer-Encoding: quoted-printable

/*
 * Arbitrary pattern trigger
 *
 * Copyright 2015, Epsiline
 *
 * Author : Rapha=EBl Teysseyre <rteysseyre@gmail.com>
 *
 * Idea discussed with Pavel Machek <pavel@ucw.cz> on
 * <linux-leds@vger.kernel.org> (march 2015, thread title
 * [PATCH RFC] leds: Add status code trigger)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */

#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/leds.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/timer.h>
#include "../leds.h"

struct pattern_trig_data {
	struct led_classdev *led_cdev;

	struct led_pattern *steps; /* Array describing the pattern */
	struct mutex lock;
	char is_sane;
	struct led_pattern *curr;
	struct led_pattern *next;
	int delta_t; /* Time in current step */
	int nsteps;  /* Number of steps */
	int repeat;  /* < 0 means repeat indefinitely */
	struct timer_list timer;
};

#define MAX_NSTEPS (PAGE_SIZE/4)
/* The "pattern" attribute contains at most PAGE_SIZE characters.
   Each line in this attribute is at least 4 characters long
   (a 1-digit number for the led brighntess, a space,
   a 1-digit number for the time, a semi-colon).
   Therefore, there is at most PAGE_SIZE/4 steps. */

#define UPDATE_INTERVAL 50
/* When doing gradual dimming, the led brightness
   will be updated every UPDATE_INTERVAL milliseconds */

#define PATTERN_SEPARATOR ","

static int pattern_trig_initialize_data(struct pattern_trig_data *data)
{
	mutex_init(&data->lock);
	mutex_lock(&data->lock);

	data->is_sane =3D 0;
	data->steps =3D kzalloc(MAX_NSTEPS*sizeof(struct led_pattern),
			GFP_KERNEL);
	if (!data->steps)
		return -ENOMEM;

	data->curr =3D NULL;
	data->next =3D NULL;
	data->delta_t =3D 0;
	data->nsteps =3D 0;
	data->repeat =3D -1;
	//data->timer =3D __TIMER_INITIALIZER(NULL, 0);

	mutex_unlock(&data->lock);
	return 0;
}

static void pattern_trig_clear_data(struct pattern_trig_data *data)
{
	data->is_sane =3D 0;
	kfree(data->steps);
}

/*
 *  is_sane : pattern checking.
 *  A pattern satisfying these three conditions is reported as sane :
 *    - At least two steps
 *    - At least one step with time >=3D UPDATE_INTERVAL
 *    - At least two steps with differing brightnesses
 *  When @data isn't sane, a sensible brightness
 *  default is suggested in @brightness
 *
 * DO NOT call pattern_trig_update on a not-sane pattern,
 * you'll be punished with an infinite loop in the kernel.
 */
static int is_sane(struct pattern_trig_data *data, int *brightness)
{
	int i;
	char stept_ok =3D 0;
	char stepb_ok =3D 0;

	*brightness =3D 0;
	if (data->nsteps < 1)
		return 0;

	*brightness =3D data->steps[0].brightness;
	if (data->nsteps < 2)
		return 0;

	for (i =3D 0; i < data->nsteps; i++) {
		if (data->steps[i].delta_t >=3D UPDATE_INTERVAL) {
			/* FIXME: this is wrong */
			if (stepb_ok)
				return 1;
			stept_ok =3D 1;
		}
		if (data->steps[i].brightness !=3D data->steps[0].brightness) {
			if (stept_ok)
				return 1;
			stepb_ok =3D 1;
		}
	}

	return 0;
}

static void reset_pattern(struct pattern_trig_data *data,
			struct led_classdev *led_cdev)
{
	int brightness;

	if (led_cdev->pattern_clear) {
		led_cdev->pattern_clear(led_cdev);
	}

	del_timer_sync(&data->timer);

	if (led_cdev->pattern_set && led_cdev->pattern_set(led_cdev, data->steps, =
data->nsteps)) {
		return;
	}
	=09
	if (!is_sane(data, &brightness)) {
		led_set_brightness(led_cdev, brightness);
		return;
	}

	data->curr =3D data->steps;
	data->next =3D data->steps + 1;
	data->delta_t =3D 0;
	data->is_sane =3D 1;

	data->timer.expires =3D jiffies;
	add_timer(&data->timer);
}

/* --- Sysfs handling --- */

static ssize_t pattern_trig_show_repeat(
	struct device *dev, struct device_attribute *attr, char *buf)
{
	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
	struct pattern_trig_data *data =3D led_cdev->trigger_data;

	return scnprintf(buf, PAGE_SIZE, "%d\n", data->repeat);
}

static ssize_t pattern_trig_store_repeat(
	struct device *dev, struct device_attribute *attr,
	const char *buf, size_t count)
{
	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
	struct pattern_trig_data *data =3D led_cdev->trigger_data;
	long res;
	int err;

	err =3D kstrtol(buf, 10, &res);
	if (err)
		return err;

	data->repeat =3D res < 0 ? -1 : res;
	reset_pattern(data, led_cdev);

	return count;
}

DEVICE_ATTR(repeat, S_IRUGO | S_IWUSR,
	pattern_trig_show_repeat, pattern_trig_store_repeat);

static ssize_t pattern_trig_show_pattern(
	struct device *dev, struct device_attribute *attr, char *buf)
{
	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
	struct pattern_trig_data *data =3D led_cdev->trigger_data;
	ssize_t count =3D 0;
	int i;

	if (!data->steps || !data->nsteps)
		return 0;

	for (i =3D 0; i < data->nsteps; i++)
		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
				"%d %d" PATTERN_SEPARATOR,
				data->steps[i].brightness,
				data->steps[i].delta_t);
	buf[count - 1] =3D '\n';
	buf[count] =3D '\0';

	return count + 1;
}

static ssize_t pattern_trig_store_pattern(
	struct device *dev, struct device_attribute *attr,
	const char *buf, size_t count)
{
	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
	struct pattern_trig_data *data =3D led_cdev->trigger_data;
	int cr =3D 0; /* Characters read on one conversion */
	int tcr =3D 0; /* Total characters read */
	int ccount; /* Number of successful conversions */

	mutex_lock(&data->lock);
	data->is_sane =3D 0;

	for (data->nsteps =3D 0; data->nsteps < MAX_NSTEPS; data->nsteps++) {
		cr =3D 0;
		ccount =3D sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "%n",
			&data->steps[data->nsteps].brightness,
			&data->steps[data->nsteps].delta_t, &cr);

		if (!cr) { /* Invalid syntax or end of pattern */
			if (ccount =3D=3D 2)
				data->nsteps++;
			mutex_unlock(&data->lock);
			reset_pattern(data, led_cdev);
			return count;
		}

		tcr +=3D cr;
	}

	/* Shouldn't reach that */
	WARN(1, "MAX_NSTEP too small. Please report\n");
	mutex_unlock(&data->lock);
	return count;
}

DEVICE_ATTR(pattern, S_IRUGO | S_IWUSR,
	pattern_trig_show_pattern, pattern_trig_store_pattern);

static int pattern_trig_create_sysfs_files(struct device *dev)
{
	int err;

	err =3D device_create_file(dev, &dev_attr_repeat);
	if (err)
		return err;

	err =3D device_create_file(dev, &dev_attr_pattern);
	if (err)
		device_remove_file(dev, &dev_attr_repeat);

	return err;
}

static void pattern_trig_remove_sysfs_files(struct device *dev)
{
	device_remove_file(dev, &dev_attr_pattern);
	device_remove_file(dev, &dev_attr_repeat);
}

/* --- Led intensity updating --- */

static int compute_brightness(struct pattern_trig_data *data)
{
	if (data->delta_t =3D=3D 0)
		return data->curr->brightness;

	if (data->curr->delta_t =3D=3D 0)
		return data->next->brightness;

	return data->curr->brightness + data->delta_t
		* (data->next->brightness - data->curr->brightness)
		/ data->curr->delta_t;
}

static void update_to_next_step(struct pattern_trig_data *data)
{
	data->curr =3D data->next;
	if (data->curr =3D=3D data->steps)
		data->repeat--;

	if (data->next =3D=3D data->steps + data->nsteps - 1)
		data->next =3D data->steps;
	else
		data->next++;

	data->delta_t =3D 0;
}

static void pattern_trig_update(struct timer_list *t)
{
	struct pattern_trig_data *data =3D from_timer(data, t, timer);

	mutex_lock(&data->lock);

	if (!data->is_sane || !data->repeat) {
		mutex_unlock(&data->lock);
		return;
	}

	if (data->delta_t > data->curr->delta_t)
		update_to_next_step(data);

	/* is_sane() checked that there is at least
	   one step with delta_t >=3D UPDATE_INTERVAL
	   so we won't go in an infinite loop */
	while (data->curr->delta_t < UPDATE_INTERVAL)
		update_to_next_step(data);

	if (data->next->brightness =3D=3D data->curr->brightness) {
		/* Constant brightness for this step */
		led_set_brightness(data->led_cdev, data->curr->brightness);
		mod_timer(&data->timer, jiffies
			+ msecs_to_jiffies(data->curr->delta_t));
		update_to_next_step(data);
	} else {
		/* Gradual dimming */
		led_set_brightness(data->led_cdev, compute_brightness(data));
		data->delta_t +=3D UPDATE_INTERVAL;
		mod_timer(&data->timer, jiffies
			+ msecs_to_jiffies(UPDATE_INTERVAL));
	}

	mutex_unlock(&data->lock);
}

/* --- Trigger activation --- */

static void pattern_trig_activate(struct led_classdev *led_cdev)
{
	struct pattern_trig_data *data =3D NULL;
	int err;

	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
	if (!data)
		return;

	err =3D pattern_trig_initialize_data(data);
	if (err) {
		kfree(data);
		return;
	}

	data->led_cdev =3D led_cdev;
	led_cdev->trigger_data =3D data;
	timer_setup(&data->timer, pattern_trig_update, 0);
	pattern_trig_create_sysfs_files(led_cdev->dev);
}

static void pattern_trig_deactivate(struct led_classdev *led_cdev)
{
	struct pattern_trig_data *data =3D led_cdev->trigger_data;

	if (data) {
		pattern_trig_remove_sysfs_files(led_cdev->dev);
		del_timer_sync(&data->timer);
		led_set_brightness(led_cdev, LED_OFF);
		pattern_trig_clear_data(data);
		kfree(data);
		led_cdev->trigger_data =3D NULL;
	}
}

static struct led_trigger pattern_led_trigger =3D {
	.name =3D "pattern",
	.activate =3D pattern_trig_activate,
	.deactivate =3D pattern_trig_deactivate,
};

/* --- Module loading/unloading --- */

static int __init pattern_trig_init(void)
{
	return led_trigger_register(&pattern_led_trigger);
}

static void __exit pattern_trig_exit(void)
{
	led_trigger_unregister(&pattern_led_trigger);
}

module_init(pattern_trig_init);
module_exit(pattern_trig_exit);

MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
MODULE_DESCRIPTION("Pattern LED trigger");
MODULE_LICENSE("GPL");

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ledtrig-pattern.txt"

LED Pattern Trigger
===================

This is a LED trigger allowing arbitrary pattern execution. It can do gradual
dimming. This trigger can be configured to repeat the pattern a number of
times or indefinitely. This is intended as a way of communication for embedded
systems with no screen.

The trigger can be activated from user space on LED class devices as shown
below:

  echo pattern > trigger

This adds the following sysfs attributes to the LED:

  pattern - specifies the pattern. See syntax below.

  repeat - number of times the pattern must be repeated.
	writing -1 to this file will make the pattern
	repeat indefinitely.

The pattern will be restarted each time a new value is written to
the pattern or repeat attribute. When dimming, the LED brightness
is set every 50 ms.

pattern syntax:
The pattern is specified in the pattern attribute with an array of comma-
separated "brightness/length in miliseconds" values. The two components
of each value are to be separated by a space.

For example, assuming the driven LED supports
intensity value from 0 to 255:

  echo 0 1000, 255 2000 > pattern

Will make the LED go gradually from zero-intensity to max (255) intensity
in 1000 milliseconds, then back to zero intensity in 2000 milliseconds:

LED brightness
    ^
255-|       / \            / \            /
    |      /    \         /    \         /
    |     /       \      /       \      /
    |    /          \   /          \   /
  0-|   /             \/             \/
    +---0----1----2----3----4----5----6------------> time (s)



To make the LED go instantly from one brigntess value to another,
use zero-time lengths. For example:

  echo 0 1000, 0 0, 255 2000, 255 0 > pattern

Will make the LED stay off for one second, then stay at max brightness
for two seconds:

LED brightness
    ^
255-|        +---------+    +---------+
    |        |         |    |         |
    |        |         |    |         |
    |        |         |    |         |
  0-|   -----+         +----+         +----
    +---0----1----2----3----4----5----6------------> time (s)



Patterns with less than two values, no value with time length > 50
milliseconds, or no two values with differing brightnesses will
result in the LED being set at the brightness of the first value,
or zero if the pattern contains no value.

Patterns with invalid syntax are silently swallowed and will result
in undefined behavior of the LED brightness.

Because sysfs is used to define the pattern, patterns that need more than
PAGE_SIZE characters to describe aren't supported. PAGE_SIZE is system
dependent.

# 4 step "charging" pattern
echo "0 0,  0 1000, 50 500, 50 1000, 100 500, 100 1000, 150 500, 150 1000, 200 500, 200 1000, 0 100" > pattern

--gBBFr7Ir9EOA20Yy--

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlumm7MACgkQMOfwapXb+vJHZwCfQjM6qDddW1Jxie0wfG1ZVajD
RAQAoKNfqYwy7SS9KneceY3LDeMUc0Px
=cdqy
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
