Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A60C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBD1217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBD1217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeHIMXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:23:40 -0400
Received: from sauhun.de ([88.99.104.3]:43802 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeHIMXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:23:39 -0400
Received: from localhost (p54B3374D.dip0.t-ipconnect.de [84.179.55.77])
        by pokefinder.org (Postfix) with ESMTPSA id 9879E6DEA44;
        Thu,  9 Aug 2018 11:59:31 +0200 (CEST)
Date:   Thu, 9 Aug 2018 11:59:31 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v5 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
Message-ID: <20180809095931.q3t7u3o52lxahpaf@katana>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eql3q3pitkytsxzq"
Content-Disposition: inline
In-Reply-To: <20180809091558.4317-5-hdegoede@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eql3q3pitkytsxzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 11:15:58AM +0200, Hans de Goede wrote:
> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that=
 1
> i2c-device.
>=20
> But in some rare cases the manufacturer has decided to describe multiple
> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>=20
> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> code to support this corner-case.
>=20
> This commit introduces a new i2c-multi-instantiate driver which fixes this
> in a different way. This new driver can be built as a module which will
> only loaded on affected systems.
>=20
> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> using the driver_data from the acpi_device_id it is binding to to tell it
> which chip-type (and optional irq-resource) to use when instantiating.
>=20
> Note this driver depends on a platform device being instantiated for the
> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

=46rom my I2C PoV:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--eql3q3pitkytsxzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltsEH8ACgkQFA3kzBSg
KbbFoA//a9slRbhisPPLOEQA8XhXzGrOakwuo4HeDanjTuWi7605lp8Tj6j6Acd9
VmTBpt/UB+2o8hflpmm2CLhB66ZABBMxnHySJd5agKSoBMiGrFVr6TFJ8hSBLDPp
/caPmFOQ56zq0r8sO7YU1LNFGS8OhStZfORxe+oIzMolLxX5WJ2LCVPoZBGVEF+G
BEXRtX2wr4dVPGm5c2dG6TZucAC4VEind61qHCDVOAYPK3qygF+hbA+NEt8LdKeG
piRgeZG31tKi7o2KT3eH5BE8F61wJW6uNp7GFjwyGcB6SH802Y0vDNv1q/7vTw7V
yrJPfUPHOmrdsUIhdVPNzAZL7XlkiaZI/7gqbazj0vKyLUnJep7Qv+/v8pEiWe7q
OV8WUSSp+GIhKO6ku6FUAKK/EVUilXHr85wKmQeRslCjijR0nhVWt7/qIKjAM1cQ
HAD6k4nx6FsD1wS8PVZIwA/Oboul+rvvuHgIMqvGKfKj0WyTP8WPO8xZD1dv68+0
9y3YuIN/7nSLbEeXChmAGL1uVvIlIXxqiv2fTUsuPwGOsexJkTLOuKqLr5DQf+5m
L9GNWWXrJwziUqkiOqbk39rIjmezjjwxEJeU8JVVkXzqZ76cf+cPNyo5wUoADIS3
W32xAKGVPmQozzYv3fgXnFKKp/0R0n3MwazLOGmBJrVQARRvxUI=
=zSzj
-----END PGP SIGNATURE-----

--eql3q3pitkytsxzq--
