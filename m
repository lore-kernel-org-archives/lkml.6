Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1603377-1521961821-5-8440808060802942862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES encaro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii', plain='us-ascii'
X-Attached: ADE7878-ABI-Table 1.csv
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521961820; b=hwOXW74tKeAmpQrguOrLVIBB1yJ4/aALJNrgA00DHesEKyq
    Y46ubx1PYuwEP+QhlJaJwdMfzinh5/Ptm7Q6l1M3nI9cc5ZR9r+hBhDbKHwRgqjV
    advl61hfrvWoE7Ur1QoQ/RITXid17iKL/pLv2rTA3OABhlyoPxcWY9H0Q3U0tyQn
    9LKFZvFiPWbW8IYXjpyct/IVRaizXJjdmA8pUw71CYfnN+orhTMKj5V56HA35NRm
    O7uBkY48IDYyStJ7UKm0zDFUOcXlum7mUeaavBMDzFx7m5eYOYHC1K/F5Mass1kK
    4odINvl2JbkZfFxOtDgpgEhsGgbe3Kh8shEDwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:message-id:content-type:mime-version
    :subject:date:in-reply-to:to:references:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:sender; s=
    arctest; t=1521961820; bh=PNlHznbgNBePkHF66dv8Kq+Bom20IVUjBDzOgt
    jfzzQ=; b=VVGWnSUwqJq1DUVWja+TD9FA9rFDlq2ZfP/pmNfXRB5cEk+GW+hci2
    2lS3BIoO7mlyNtLq2fphKE2V9fs8ShCPrLQ+no3HXz3gmTMdBbDwjajjVOTs4USC
    yhO0wCaB5ZhxfpkLpAtNw/qd/QDnwfpPXZhbdti02NpbvPCqHxj19Cp+mQl0E187
    cblRY4aQAeiKpOGUgHkIqklg14jJD9Ybpajp0GOR60c9F4OknOAOo4f7Czd5suWL
    troYyWVD8QSUvI8uV3yQpblK7IsFSficYIu7h0K3fsRlIOJHQl94bfmsqEGPXVI4
    5ezvefUgvb7gS5oo1p+OwH+ynuUn6JFw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b/jZ+BwG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sjV4Udov;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b/jZ+BwG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sjV4Udov;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv3p3iZLFTgIGuwCgDHYuYi60aVpOswXyW3JiL3BULY8LWpO4mwyv36vRogfO1KeELrbsjiHw==
From: John Syne <john3909@gmail.com>
Message-Id: <4E6473D1-1B27-4FF2-9BAD-36E8543C91DD@gmail.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_FC117329-CF3C-46DF-B54B-D04F6864601C"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: meter ABI: (was Re: [PATCH v2 1/3] staging:iio:meter: Replaces
 IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR)
Date: Sun, 25 Mar 2018 00:10:03 -0700
In-Reply-To: <20180324151829.7d03ad15@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
 <20180309003733.aichruo53vqryafg@smtp.gmail.com>
 <20180310151045.4570e85d@archlinux>
 <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
 <20180317203037.1093cc11@archlinux>
 <A8E3184B-765B-4730-A076-C3FCF487EAE3@gmail.com>
 <20180318122312.0d395367@archlinux>
 <F6FE75D3-5289-4675-9345-F46CABEFA99E@gmail.com>
 <20180324151829.7d03ad15@archlinux>
X-Mailer: Apple Mail (2.3445.5.20)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Apple-Mail=_FC117329-CF3C-46DF-B54B-D04F6864601C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi Jonathan,

I have attached a CSV version of this table below. Hopefully that will =
make things easier for you.

Register	IIO Attribute	Device Tree or Code	Direction	=
type	Index	Modifier	Info Mask
AIGAIN	in_current0_phaseA_scale		in	current	0	=
phaseA	scale
AVGAIN	in_voltage0_phaseA_scale		in	voltage	0	=
phaseA	scale
BIGAIN	in_current0_phaseB_scale		in	current	0	=
phaseB	scale
BVGAIN	in_voltage0_phaseB_scale		in	voltage	0	=
phaseB	scale
CIGAIN	in_current0_phaseC_scale		in	current	0	=
phaseC	scale
CVGAIN	in_voltage0_phaseC_scale		in	voltage	0	=
phaseC	scale
NIGAIN	in_current0_neutral_scale		in	current	0	=
neutral	scale
AIRMSOS	in_current0_phaseA_rms_offset		in	current	0	=
phaseA	offset
AVRMSOS	in_voltage0_phaseA_rms_offset		in	voltage	0	=
phaseA	offset
BIRMSOS	in_current0_phaseB_rms_offset		in	current	0	=
phaseB	offset
BVRMSOS	in_voltage0_phaseB_rms_offset		in	voltage	0	=
phaseB	offset
CIRMSOS	in_current0_phaseC_rms_offset		in	current	0	=
phaseC	offset
CVRMSOS	in_voltage0_phaseC_rms_offset		in	voltage	0	=
phaseC	offset
NIRMSOS	in_current0_neutral_rms_offset		in	current	0	=
neutral	offset
AVAGAIN	in_powerapparent0_phaseA_scale		in	powerapparent	=
0	phaseA	scale
BVAGAIN	in_powerapparent0_phaseB_scale		in	powerapparent	=
0	phaseB	scale
CVAGAIN	in_powerapparent0_phaseC_scale		in	powerapparent	=
0	phaseC	scale
AWGAIN	in_power0_phaseA_scale		in	power	0	phaseA	=
scale
AWATTOS	in_power0_phaseA_offset		in	power	0	phaseA	=
offset
BWGAIN	in_power0_phaseB_scale		in	power	0	phaseB	=
scale
BWATTOS	in_power0_phaseB_offset		in	power	0	phaseB	=
offset
CWGAIN	in_power0_PhaseC_scale		in	power	0	phaseC	=
scale
CWATTOS	in_power0_phaseC_offset		in	power	0	phaseC	=
offset
AVARGAIN	in_powerreactive0_phaseA_scale		in	=
powerreactive	0	phaseA	scale
AVAROS	in_powerreactive0_phaseA_offset		in	powerreactive	=
0	phaseA	offset
BVARGAIN	in_powerreactive0_phaseB_scale		in	=
powerreactive	0	phaseB	scale
BVAROS	in_powerreactive0_phaseB_offset		in	powerreactive	=
0	phaseB	offset
CVARGAIN	in_powerreactive0_phaseC_scale		in	=
powerreactive	0	phaseC	scale
CVAROS	in_powerreactive0_phaseC_offset		in	powerreactive	=
0	phaseC	offset
AFWGAIN	in_power0_phaseA_fundamental_scale		in	power	=
0	phaseA_fundamental	scale
AFWATTOS	in_power0_phaseA_fundamental_offset		in	=
power	0	phaseA_fundamental	offset
BFWGAIN	in_power0_phaseB_fundamental_scale		in	power	=
0	phaseB_fundamental	scale
BFWATTOS	in_power0_phaseB_fundamental_offset		in	=
power	0	phaseB_fundamental	offset
CFWGAIN	in_power0_phaseC_fundamental_scale		in	power	=
0	phaseC_fundamental	scale
CFWATTOS	in_power0_phaseC_fundamental_offset		in	=
power	0	phaseC_fundamental	offset
AFVARGAIN	in_powerreactive0_phaseA_fundamental_scale		=
in	powerreactive	0	phaseA_fundamental	scale
AFVAROS	in_powerreactive0_phaseA_fundamental_offset		in	=
powerreactive	0	phaseA_fundamental	offset
BFVARGAIN	in_powerreactive0_phaseB_fundamental_scale		=
in	powerreactive	0	phaseB_fundamental	scale
BFVAROS	in_powerreactive0_phaseB_fundamental_offset		in	=
powerreactive	0	phaseB_fundamental	offset
CFVARGAIN	in_powerreactive0_phaseC_fundamental_scale		=
in	powerreactive	0	phaseC_fundamental	scale
CFVAROS	in_powerreactive0_phaseC_fundamental_offset		in	=
powerreactive	0	phaseC_fundamental	offset
VATHR1	VATHR1	DT				=09
VATHR0	VATHR0	DT				=09
WTHR1	WTHR1	DT				=09
WTHR0	WTHR0	DT				=09
VARTHR1	VARTHR1	DT				=09
VARTHR0	VARTHR0	DT				=09
Reserved	Reserved					=09
VANOLOAD	VANOLOAD	DT				=09
APNOLOAD	APNOLOAD	DT				=09
VLEVEL	VLEVEL	DT				=09
DICOEFF	DICOEFF	DT				=09
HPFDIS	HPFDIS	DT				=09
ISUMLVL	ISUMLVL	DT	in			=09
ISUM	in_current0_phaseA&phaseB&phaseC_sum		in	current	=
0	phaseA&phaseB&phaseC	sum
AIRMS	in_current0_phaseA_rms_raw		in	current	0	=
phaseA_rms	raw
AVRMS	in_voltage0_phaseA_rms_raw		in	voltage	0	=
phaseA_rms	raw
BIRMS	in_current0_phaseB_rms_raw		in	current	0	=
phaseB_rms	raw
BVRMS	in_voltage0_phaseB_rms_raw		in	voltage	0	=
phaseB_rms	raw
CIRMS	in_current0_phaseC_rms_raw		in	current	0	=
phaseC_rms	raw
CVRMS	in_voltage0_phaseC_rms_raw		in	voltage	0	=
phaseC_rms	raw
NIRMS	in_current0_neutral_rms_raw		in	current	0	=
neutral_rms	raw
Run		Code	in			=09
AWATTHR	in_energy0_phaseA_raw_raw		in	energy	0	=
phaseA	raw
BWATTHR	in_energy0_phaseB_raw_raw		in	energy	0	=
phaseB	raw
CWATTHR	in_energy0_phaseC_raw_raw		in	energy	0	=
phaseC	raw
AFWATTHR	in_energy0_phaseA_fundamental_raw		in	=
energy	0	phaseA_fundamental	raw
BFWATTHR	in_energy0_phaseB_fundamental_raw		in	=
energy	0	phaseB_fundamental	raw
CFWATTHR	in_energy0_phaseC_fundamental_raw		in	=
energy	0	phaseC_fundamental	raw
AVARHR	in_energyreactive0_phaseA_raw		in	energyreactive	=
0	phaseA	raw
BVARHR	in_energyreactive0_phaseB_raw		in	energyreactive	=
0	phaseB	raw
CVARHR	in_energyreactive0_phaseC_raw		in	energyreactive	=
0	phaseC	raw
AFVARHR	in_energyreactive0_phaseA_fundamental_raw		in	=
energyreactive	0	phaseA_fundamental	raw
BFVARHR	in_energyreactive0_phaseB_fundamental_raw		in	=
energyreactive	0	phaseB_fundamental	raw
CFVARHR	in_energyreactive0_phaseC_fundamental_raw		in	=
energyreactive	0	phaseC_fundamental	raw
AVAHR	in_energyapparent0_phaseA_raw		in	energyapparent	=
0	phaseA	raw
BVAHR	in_energyapparent0_phaseB_raw		in	energyapparent	=
0	phaseB	raw
CVAHR	in_energyapparent0_phaseC_raw		in	energyapparent	=
0	phaseC	raw
IPEAK	in_current0_peak		in	current	0		=
peak
VPEAK	in_voltage0_peak		in	voltage	0		=
peak
STATUS0		event				=09
STATUS1		event				=09
AIMAV	in_current0_phaseA_mav_raw		in	current		=
phaseA_mav	raw
BIMAV	in_current0_phaseB_mav_raw		in	current		=
phaseB_mav	raw
CIMAV	in_current0_phaseC_mav_raw		in	current		=
phaseC_mav	raw
OILVL	OILVL	DT				=09
OVLVL	OVLVL	DT				=09
SAGLVL	SAGLVL	DT				=09
MASK0	in_mask0_raw		in	mask	0		raw
MASK1	in_mask1_raw		in	mask	1		raw
IAWV	in_current0_phaseA_instantaneous					=
=09
IBWV	in_current0_phaseB_instantaneous					=
=09
ICWV	in_current0_phaseC_instantaneous					=
=09
INWV	in_current0_phaseN_instantaneous					=
=09
VAWV	in_voltage0_phaseA_instantaneous					=
=09
VBWV	in_voltage0_phaseB_instantaneous					=
=09
VCWV	in_voltage0_phaseC_instantaneous					=
=09
AWATT	in_power0_phaseA_instantaneous					=09=

BWATT	in_power0_phaseB_instantaneous					=09=

CWATT	in_power0_phaseC_instantaneous					=09=

AVAR	in_powerreactive0_phaseA_instantaneous					=
=09
BVAR	in_powerreactive0_phaseB_instantaneous					=
=09
CVAR	in_powerreactive0_phaseC_instantaneous					=
=09
AVA	in_powerapparent0_phaseA_instantaneous					=
=09
BVA	in_powerapparent0_phaseB_instantaneous					=
=09
CVA	in_powerappatent0_phaseC_instantaneous					=
=09
CHECKSUM	CHECKSUM	Code				=09
VNOM	VNOM	DT				=09
PHSTATUS		event				=09
ANGLE0	ANGLE0	DT				=09
ANGLE1	ANGLE1	DT				=09
ANGLE2	ANGLE2	DT				=09
Reserved						=09
PERIOD	in_period_raw		in	period			raw
PHNOLOAD		event				=09
LINECYC	in_count0_cycle_raw		in	count	0	cycle	=
raw
ZXTOUT	ZXTOUT	DT				=09
COMPMODE	COMPMODE	DT				=09
Gain	Gain	DT				=09
CFMODE	CFMODE	DT				=09
CF1DEN	CF1DEN	DT				=09
CF2DEN	CF2DEN	DT				=09
CF3DEN	CF3DEN	DT				=09
APHCAL	APHCAL	DT				=09
BPHCAL	BPHCAL	DT				=09
CPHCAL	CPHCAL	DT				=09
PHSIGN	PHSIGN	DT				=09
CONFIG	CONFIG	DT				=09
MMODE	MMODE	DT				=09
ACCMODE	ACCMODE	DT				=09
LCYCMODE	LCYCMODE	DT				=09
PEAKCYC	PEAKCYC	DT				=09
SAGCYC	SAGCYC	DT				=09
CFCYC	CFCYC	DT				=09
HSDC_CFG	HSDC_CFG	DT				=09
Version	in_version_raw		in	version			raw
Reserved		DT				=09
LPOILVL	LPOILVL	DT				=09
CONFIG2	CONFIG2	DT				=09


--Apple-Mail=_FC117329-CF3C-46DF-B54B-D04F6864601C
Content-Disposition: attachment;
	filename="ADE7878-ABI-Table 1.csv"
Content-Type: text/csv;
	x-unix-mode=0644;
	name="ADE7878-ABI-Table 1.csv"
Content-Transfer-Encoding: quoted-printable

Register,IIO Attribute,Device Tree or =
Code,Direction,type,Index,Modifier,Info Mask=0D
AIGAIN,in_current0_phaseA_scale,,in,current,0,phaseA,scale=0D
AVGAIN,in_voltage0_phaseA_scale,,in,voltage,0,phaseA,scale=0D
BIGAIN,in_current0_phaseB_scale,,in,current,0,phaseB,scale=0D
BVGAIN,in_voltage0_phaseB_scale,,in,voltage,0,phaseB,scale=0D
CIGAIN,in_current0_phaseC_scale,,in,current,0,phaseC,scale=0D
CVGAIN,in_voltage0_phaseC_scale,,in,voltage,0,phaseC,scale=0D
NIGAIN,in_current0_neutral_scale,,in,current,0,neutral,scale=0D
AIRMSOS,in_current0_phaseA_rms_offset,,in,current,0,phaseA,offset=0D
AVRMSOS,in_voltage0_phaseA_rms_offset,,in,voltage,0,phaseA,offset=0D
BIRMSOS,in_current0_phaseB_rms_offset,,in,current,0,phaseB,offset=0D
BVRMSOS,in_voltage0_phaseB_rms_offset,,in,voltage,0,phaseB,offset=0D
CIRMSOS,in_current0_phaseC_rms_offset,,in,current,0,phaseC,offset=0D
CVRMSOS,in_voltage0_phaseC_rms_offset,,in,voltage,0,phaseC,offset=0D
NIRMSOS,in_current0_neutral_rms_offset,,in,current,0,neutral,offset=0D
AVAGAIN,in_powerapparent0_phaseA_scale,,in,powerapparent,0,phaseA,scale=0D=

BVAGAIN,in_powerapparent0_phaseB_scale,,in,powerapparent,0,phaseB,scale=0D=

CVAGAIN,in_powerapparent0_phaseC_scale,,in,powerapparent,0,phaseC,scale=0D=

AWGAIN,in_power0_phaseA_scale,,in,power,0,phaseA,scale=0D
AWATTOS,in_power0_phaseA_offset,,in,power,0,phaseA,offset=0D
BWGAIN,in_power0_phaseB_scale,,in,power,0,phaseB,scale=0D
BWATTOS,in_power0_phaseB_offset,,in,power,0,phaseB,offset=0D
CWGAIN,in_power0_PhaseC_scale,,in,power,0,phaseC,scale=0D
CWATTOS,in_power0_phaseC_offset,,in,power,0,phaseC,offset=0D
AVARGAIN,in_powerreactive0_phaseA_scale,,in,powerreactive,0,phaseA,scale=0D=

AVAROS,in_powerreactive0_phaseA_offset,,in,powerreactive,0,phaseA,offset=0D=

BVARGAIN,in_powerreactive0_phaseB_scale,,in,powerreactive,0,phaseB,scale=0D=

BVAROS,in_powerreactive0_phaseB_offset,,in,powerreactive,0,phaseB,offset=0D=

CVARGAIN,in_powerreactive0_phaseC_scale,,in,powerreactive,0,phaseC,scale=0D=

CVAROS,in_powerreactive0_phaseC_offset,,in,powerreactive,0,phaseC,offset=0D=

=
AFWGAIN,in_power0_phaseA_fundamental_scale,,in,power,0,phaseA_fundamental,=
scale=0D
=
AFWATTOS,in_power0_phaseA_fundamental_offset,,in,power,0,phaseA_fundamenta=
l,offset=0D
=
BFWGAIN,in_power0_phaseB_fundamental_scale,,in,power,0,phaseB_fundamental,=
scale=0D
=
BFWATTOS,in_power0_phaseB_fundamental_offset,,in,power,0,phaseB_fundamenta=
l,offset=0D
=
CFWGAIN,in_power0_phaseC_fundamental_scale,,in,power,0,phaseC_fundamental,=
scale=0D
=
CFWATTOS,in_power0_phaseC_fundamental_offset,,in,power,0,phaseC_fundamenta=
l,offset=0D
=
AFVARGAIN,in_powerreactive0_phaseA_fundamental_scale,,in,powerreactive,0,p=
haseA_fundamental,scale=0D
=
AFVAROS,in_powerreactive0_phaseA_fundamental_offset,,in,powerreactive,0,ph=
aseA_fundamental,offset=0D
=
BFVARGAIN,in_powerreactive0_phaseB_fundamental_scale,,in,powerreactive,0,p=
haseB_fundamental,scale=0D
=
BFVAROS,in_powerreactive0_phaseB_fundamental_offset,,in,powerreactive,0,ph=
aseB_fundamental,offset=0D
=
CFVARGAIN,in_powerreactive0_phaseC_fundamental_scale,,in,powerreactive,0,p=
haseC_fundamental,scale=0D
=
CFVAROS,in_powerreactive0_phaseC_fundamental_offset,,in,powerreactive,0,ph=
aseC_fundamental,offset=0D
VATHR1,VATHR1,DT,,,,,=0D
VATHR0,VATHR0,DT,,,,,=0D
WTHR1,WTHR1,DT,,,,,=0D
WTHR0,WTHR0,DT,,,,,=0D
VARTHR1,VARTHR1,DT,,,,,=0D
VARTHR0,VARTHR0,DT,,,,,=0D
Reserved,Reserved,,,,,,=0D
VANOLOAD,VANOLOAD,DT,,,,,=0D
APNOLOAD,APNOLOAD,DT,,,,,=0D
VLEVEL,VLEVEL,DT,,,,,=0D
DICOEFF,DICOEFF,DT,,,,,=0D
HPFDIS,HPFDIS,DT,,,,,=0D
ISUMLVL,ISUMLVL,DT,in,,,,=0D
=
ISUM,in_current0_phaseA&phaseB&phaseC_sum,,in,current,0,phaseA&phaseB&phas=
eC,sum=0D
AIRMS,in_current0_phaseA_rms_raw,,in,current,0,phaseA_rms,raw=0D
AVRMS,in_voltage0_phaseA_rms_raw,,in,voltage,0,phaseA_rms,raw=0D
BIRMS,in_current0_phaseB_rms_raw,,in,current,0,phaseB_rms,raw=0D
BVRMS,in_voltage0_phaseB_rms_raw,,in,voltage,0,phaseB_rms,raw=0D
CIRMS,in_current0_phaseC_rms_raw,,in,current,0,phaseC_rms,raw=0D
CVRMS,in_voltage0_phaseC_rms_raw,,in,voltage,0,phaseC_rms,raw=0D
NIRMS,in_current0_neutral_rms_raw,,in,current,0,neutral_rms,raw=0D
Run,,Code,in,,,,=0D
AWATTHR,in_energy0_phaseA_raw_raw,,in,energy,0,phaseA,raw=0D
BWATTHR,in_energy0_phaseB_raw_raw,,in,energy,0,phaseB,raw=0D
CWATTHR,in_energy0_phaseC_raw_raw,,in,energy,0,phaseC,raw=0D
=
AFWATTHR,in_energy0_phaseA_fundamental_raw,,in,energy,0,phaseA_fundamental=
,raw=0D
=
BFWATTHR,in_energy0_phaseB_fundamental_raw,,in,energy,0,phaseB_fundamental=
,raw=0D
=
CFWATTHR,in_energy0_phaseC_fundamental_raw,,in,energy,0,phaseC_fundamental=
,raw=0D
AVARHR,in_energyreactive0_phaseA_raw,,in,energyreactive,0,phaseA,raw=0D
BVARHR,in_energyreactive0_phaseB_raw,,in,energyreactive,0,phaseB,raw=0D
CVARHR,in_energyreactive0_phaseC_raw,,in,energyreactive,0,phaseC,raw=0D
=
AFVARHR,in_energyreactive0_phaseA_fundamental_raw,,in,energyreactive,0,pha=
seA_fundamental,raw=0D
=
BFVARHR,in_energyreactive0_phaseB_fundamental_raw,,in,energyreactive,0,pha=
seB_fundamental,raw=0D
=
CFVARHR,in_energyreactive0_phaseC_fundamental_raw,,in,energyreactive,0,pha=
seC_fundamental,raw=0D
AVAHR,in_energyapparent0_phaseA_raw,,in,energyapparent,0,phaseA,raw=0D
BVAHR,in_energyapparent0_phaseB_raw,,in,energyapparent,0,phaseB,raw=0D
CVAHR,in_energyapparent0_phaseC_raw,,in,energyapparent,0,phaseC,raw=0D
IPEAK,in_current0_peak,,in,current,0,,peak=0D
VPEAK,in_voltage0_peak,,in,voltage,0,,peak=0D
STATUS0,,event,,,,,=0D
STATUS1,,event,,,,,=0D
AIMAV,in_current0_phaseA_mav_raw,,in,current,,phaseA_mav,raw=0D
BIMAV,in_current0_phaseB_mav_raw,,in,current,,phaseB_mav,raw=0D
CIMAV,in_current0_phaseC_mav_raw,,in,current,,phaseC_mav,raw=0D
OILVL,OILVL,DT,,,,,=0D
OVLVL,OVLVL,DT,,,,,=0D
SAGLVL,SAGLVL,DT,,,,,=0D
MASK0,in_mask0_raw,,in,mask,0,,raw=0D
MASK1,in_mask1_raw,,in,mask,1,,raw=0D
IAWV,in_current0_phaseA_instantaneous,,,,,,=0D
IBWV,in_current0_phaseB_instantaneous,,,,,,=0D
ICWV,in_current0_phaseC_instantaneous,,,,,,=0D
INWV,in_current0_phaseN_instantaneous,,,,,,=0D
VAWV,in_voltage0_phaseA_instantaneous,,,,,,=0D
VBWV,in_voltage0_phaseB_instantaneous,,,,,,=0D
VCWV,in_voltage0_phaseC_instantaneous,,,,,,=0D
AWATT,in_power0_phaseA_instantaneous,,,,,,=0D
BWATT,in_power0_phaseB_instantaneous,,,,,,=0D
CWATT,in_power0_phaseC_instantaneous,,,,,,=0D
AVAR,in_powerreactive0_phaseA_instantaneous,,,,,,=0D
BVAR,in_powerreactive0_phaseB_instantaneous,,,,,,=0D
CVAR,in_powerreactive0_phaseC_instantaneous,,,,,,=0D
AVA,in_powerapparent0_phaseA_instantaneous,,,,,,=0D
BVA,in_powerapparent0_phaseB_instantaneous,,,,,,=0D
CVA,in_powerappatent0_phaseC_instantaneous,,,,,,=0D
CHECKSUM,CHECKSUM,Code,,,,,=0D
VNOM,VNOM,DT,,,,,=0D
PHSTATUS,,event,,,,,=0D
ANGLE0,ANGLE0,DT,,,,,=0D
ANGLE1,ANGLE1,DT,,,,,=0D
ANGLE2,ANGLE2,DT,,,,,=0D
Reserved,,,,,,,=0D
PERIOD,in_period_raw,,in,period,,,raw=0D
PHNOLOAD,,event,,,,,=0D
LINECYC,in_count0_cycle_raw,,in,count,0,cycle,raw=0D
ZXTOUT,ZXTOUT,DT,,,,,=0D
COMPMODE,COMPMODE,DT,,,,,=0D
Gain,Gain,DT,,,,,=0D
CFMODE,CFMODE,DT,,,,,=0D
CF1DEN,CF1DEN,DT,,,,,=0D
CF2DEN,CF2DEN,DT,,,,,=0D
CF3DEN,CF3DEN,DT,,,,,=0D
APHCAL,APHCAL,DT,,,,,=0D
BPHCAL,BPHCAL,DT,,,,,=0D
CPHCAL,CPHCAL,DT,,,,,=0D
PHSIGN,PHSIGN,DT,,,,,=0D
CONFIG,CONFIG,DT,,,,,=0D
MMODE,MMODE,DT,,,,,=0D
ACCMODE,ACCMODE,DT,,,,,=0D
LCYCMODE,LCYCMODE,DT,,,,,=0D
PEAKCYC,PEAKCYC,DT,,,,,=0D
SAGCYC,SAGCYC,DT,,,,,=0D
CFCYC,CFCYC,DT,,,,,=0D
HSDC_CFG,HSDC_CFG,DT,,,,,=0D
Version,in_version_raw,,in,version,,,raw=0D
Reserved,,DT,,,,,=0D
LPOILVL,LPOILVL,DT,,,,,=0D
CONFIG2,CONFIG2,DT,,,,,=

--Apple-Mail=_FC117329-CF3C-46DF-B54B-D04F6864601C
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



Regards,
John






--Apple-Mail=_FC117329-CF3C-46DF-B54B-D04F6864601C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--Apple-Mail=_FC117329-CF3C-46DF-B54B-D04F6864601C--
