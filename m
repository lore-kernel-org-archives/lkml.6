Return-Path: <hzpeterchen@gmail.com>
X-Google-Smtp-Source: AH8x224C0iA3uC+OJaEwfsJpC5UUErI/DorTvkHiBHbVwwISU/zZv19pWZ16oPYlch8d5H9a3jkO
ARC-Seal: i=1; a=rsa-sha256; t=1517977292; cv=none;
        d=google.com; s=arc-20160816;
        b=yxbVrK2BC72283b51zWd+la5t3AFhle9/j6ZubUmWVxbV7wZdmALclL7hn2bXtnMKI
         Av/VOATjsDIBEUcfyF03dEKTjdYvMEJPtQlehEg1NS+oOXTsULbfbZ0lkroTTSc+Vjgb
         gS6aXVd+H3BnX1pxO1U2S2pYFHU/iVrszn13Ng3/gwYDmeEGmgZa272quBmSqhEtu1M3
         1l4iiapnpao+bpgd2pZcTlG8k3gNxNZNONoEbbsItpa0S6hl1DYvKrb/r/O2aWAbbZGW
         HF8kYT5TLlvBIc2JTp46YiWa89CyAvcxsKczigMeHyz4pLjbUZChG8npGHkVnC1bbE9J
         OhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=ppscbESS55DqbrGhMYrNODz8oe/N5fPoyQNz824qp9A=;
        b=u1lr4Gv7LyazI431/fHKaIcYBEvnX/xjHxmZqNbecGmQFVdvim3C3rX8/kVQHfpcnH
         PK1c8kvHIoaAhPQayoONtDymBCfjS7L43JpLu0ZNRzacIaKC9N17GHyaycta9MOZxyA1
         TAdK0MXvf8Wr61aExAZpMhIAIL8Nf/0aW8cBogy8TaocQc+1uQcXxXbKP+fGV9bQ5nn8
         CEswaciEBhF58l3+r6UYLkFV+51IA1kyQezrynerJXAZdKJL7xCLLlstkTtiG2Xztmkt
         pYI6qTe/1cGFC773qpJj1Nk6RgRbfLC1RF2VhK54put6GtsrnUHivQAmTsBY+kWEKHb5
         YCkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning hzpeterchen@gmail.com does not designate 104.47.36.71 as permitted sender) smtp.mailfrom=hzpeterchen@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning hzpeterchen@gmail.com does not designate 104.47.36.71 as permitted sender) smtp.mailfrom=hzpeterchen@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: spf=softfail (sender IP is 192.88.168.50)
 smtp.mailfrom=gmail.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=fail action=none
 header.from=gmail.com;
Date: Wed, 7 Feb 2018 09:48:24 +0800
From: Peter Chen <hzpeterchen@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
CC: Peter Chen <Peter.Chen@nxp.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ian Ray <ian.ray@ge.com>, Nandor Han
	<nandor.han@ge.com>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	<kernel@lists.collabora.co.uk>
Subject: Re: [PATCH 2/2] usb: chipidea: imx: Fix ULPI on imx53
Message-ID: <20180207014824.GA31270@b29397-desktop>
References: <20180124171439.10721-1-sebastian.reichel@collabora.co.uk>
 <20180124171439.10721-2-sebastian.reichel@collabora.co.uk>
 <20180129033315.GA20311@b29397-desktop>
 <20180206155041.objiu5j5kftmzp4q@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180206155041.objiu5j5kftmzp4q@earth.universe>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131624508910698760;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(2980300002)(199004)(189003)(104016004)(316002)(26826003)(336011)(76176011)(77096007)(498600001)(2906002)(33896004)(6862004)(33716001)(107886003)(83322999)(86362001)(76482006)(356003)(54906003)(50466002)(73392002)(53936002)(81156014)(305945005)(81166006)(8676002)(8936002)(83506002)(26005)(4326008)(16586007)(1076002)(68736007)(93886005)(82202002)(6246003)(81442002)(46406003)(47776003)(97736004)(73972006)(58126008)(9686003)(55016002)(33656002)(23726003)(5660300001)(87572001)(97756001)(229853002)(106466001)(2950100002)(105596002)(6666003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0301MB0607;H:tx30smr01.am.freescale.net;FPR:;SPF:SoftFail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD004;1:ohDBo/4EPW0r3pkqp1j4NtBhOBpSGu/6hrvGqLCdX9RGnASwWePzmKjg9uxTnluUUgaJI9R2avRybCEzdHFnPkOpVu9zQJ+JHzmBZvi1JKNiC9E4L8Mo3nEIZA+Afq6L
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998900ec-b72b-46d9-7600-08d56de243bf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:DM2PR0301MB0607;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0607;3:sKce+r8ZXVxjeSKXvpyPwBBidildRkjS+DEXkYr2ZzQRS7bH6GbWpwdW+JUWdX3DDBNjx863RVn8TfjplLnAexHsqs/xOYv8VpBcPnkzkRoWjRlefpGIdmFgOcgk/Ex/5FMgacMtQJaesy6WP58u7No4/6FpaVdDCtLjY4l/HERCLeoKnNVaaoOpWYlbpkYK5nMA0tMEC82ETZFUwdGUGxDHWhVEEtBTICzX/rjCRKZGAgIr8VZ+OIqeKc3bZi4QOjeA/Xqnfaart2jBR3vG+jRByRHFfRIkHTBOeTdpCDnUdCN4a6SrRQ8ip6AcT+d/9eywyviVtUbtnicMQl7BTiTTlQXHph8bfE/VliaSq1s=;25:rQJNkAAEliS/b1rm6DnhEngPwlop8lft+ONA38R7cvBjop9OoSeClVVJPlpASBZe24CIoBzGNujm5H0aX6b8b8ZSbpCuJWPiPh3iXMnOKOB5q9phq26T0OET7yabgSW2TZWhSs0MlUPsjf4IGY7fVEq2h6H5tp0RAeE3puV9dxP40YEEAf3mkER5LAGuITchDdE5+7sTX9G9YLluSBbGNCKhk5Uq2eAswM49TXdqeZds2HYpnEeDXbO15MKu1MRwOtB47T8uQ6HiRu03nS5iy+VWFQcWmv3bhnaGCHmmgdaDFFDH38AIJ7nJw7+XRjcSzLIvweSwBHOZ0/3oZIPQYw==
X-MS-TrafficTypeDiagnostic: DM2PR0301MB0607:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0607;31:zu7xPkyP8yEKq8pS57mQ0VbW89WtN2bzqRD8hfljICD35XlzgaezwETr1uLPlxWaTiIcx/ECn6ga2pK9brAXI086yO6lu9Vzh+Y88dkP5AgIh8HQr9Ib2BfOgeyfMoR5xxurJ1O2tYaM9lHGlJuKkf1z0N5K4BHful8FyfPMM8llv8omWfim/xsCiJP2faPsqsT/JDGAP6Kn+pwZam0J2icPxvRylkIe8fw+Rdhe+PU=;4:k38NwLbstZoVacJbMRRImGTS1plIGuzp26IR5jC1Otwht6k5oFQZyVHcdHSCyuX9PV4IA1TWeeSyUKc2eFCtBH60xh/uSR1TzT/omoIXEA3uBbpyW3xKdyhCLbBle498jMDZ6nkAYZc4XScV4WcwYDLKBj+2RisAXNDWUTr5XVTapt7DGg7voqj9Rv46m8uFEE54jTN8/0nUytNmgcSUoleHEMq35NtRtnN8iy8F7oPXLhiTKPAjmIPD0vglu01lzx3QsnOtg7JNYMsNdIHQMw==
X-Microsoft-Antispam-PRVS: <DM2PR0301MB0607F0DAF7F63A95C02C13EDBFFC0@DM2PR0301MB0607.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6096035)(20161123563025)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123559100)(20161123556025)(201708071742011);SRVR:DM2PR0301MB0607;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR0301MB0607;
X-Forefront-PRVS: 0576145E86
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0301MB0607;23:VlvziFc1SPBDQKXnz/BBimkaLyj3kTkZSdyHeqG?=
 =?us-ascii?Q?ynb5gxDEcaLv734UmaNwKr1KdfHzACyETHEjwb7fLiChW4yBXeRpiLI8T+Eb?=
 =?us-ascii?Q?7VJsqdKQL59Dot5BkXvwXXly1xZJzz1svwmVeQnzzdAhl/dJJfAF5tkeg9xK?=
 =?us-ascii?Q?YKVTwnllq8r79xxlH0nDNZsC4EYp58AcLWpqhUfNl/lhRUhq3tVXXYsOyihn?=
 =?us-ascii?Q?yPQ0xi1CxtGAeND35sPPwxu78Wre1zX0fFfPB7LTYSJWxkKzBCbiukGyu24k?=
 =?us-ascii?Q?JypAJqPqDgnllmiWeTBswEaNYwNQz6Bn3kUUofxJbkuRmQeqOgMgSfPmOJv4?=
 =?us-ascii?Q?hyM0tkgPT4g4Ap4BWgZc46povUyjqPm+kag6bKW2e3mCcuBOVPBj8xNKZww2?=
 =?us-ascii?Q?MiWttysfz8hnGSnqVfv6BrN2GxHQfyYNOnwW7BAFgbfOjtwAQbnuIQdCAvgC?=
 =?us-ascii?Q?SLJPAuy7O+pqGIHrc7XiHV4di/DR7FeLHXOOWMQS6RZHDgbXnkW8aKLFQc6/?=
 =?us-ascii?Q?2mJH42varUUJsxPLKh0KV5pJExjT0Bt1V0VkqmXJ8SB1HOBcEioQHbfElJ3a?=
 =?us-ascii?Q?s3gG0gYwvLEJ3KRnY3euaBs1lQDWFYyEUaVjpHj8aJoqDvngUlwGeQ8xea2e?=
 =?us-ascii?Q?NILTyq9C4ASytQDeg7tj7ROPZqMkqZf4sUoMyfN1q9dTeHxHRNDNf8NWZy2j?=
 =?us-ascii?Q?P35mbbfRbfg/L2GC5na3W31P/RLtUYCsKVNPS/WooL5lX7BMaSwYZNkXUlpE?=
 =?us-ascii?Q?2UGuamDkywtKzGyeXUn+MsM8JGOg/T5AADv70ot9muhlmlkFB4U04dXowUJv?=
 =?us-ascii?Q?jDJY1Gd5sEatUT1XA4pLy7shfs2HJKBsg6OaJrzWi/H/2R1dzVDgRTOMvWe8?=
 =?us-ascii?Q?tHFeoxQd4fGnsGHUO2T6CTHmouLE5VEVQ4gGH84So0JRjFyQIDzhEGiJvJ5q?=
 =?us-ascii?Q?up0X6Iv6J01ocE0DIzU09PcrixWqLLmMtE+FPMVq5gsdgV97JYqGlYyYid9q?=
 =?us-ascii?Q?dt781uJ0JsyhfP/AmmhNr8RQnTzKO5KFVsX80XVNUdKnYSecN+dYM06LnTwo?=
 =?us-ascii?Q?cy0PJHRbpLkZ1b7rkOAaffMiMl6yrciBdcn1f0n+y+n1WmFEW5da/jASn+Cc?=
 =?us-ascii?Q?Bd+Gr2aHeB0VPeOyU/zQNwZau4Y551I04+AvpZYaWlgLYB9vgLCbPNEbqc7q?=
 =?us-ascii?Q?5OXZ7t7Gr5vgg3b612DE90BxEy4QDmcfvlFXsfTqCok+sKVYcIG1UcmEQYA/?=
 =?us-ascii?Q?Fnh5gJOu1Pd0CiK/YocttVz7y//kRstYprfOXhEqVduAeXM6J/rChU+iF1fG?=
 =?us-ascii?Q?T1FbnanLOgUjb3dviNMroTFZQeF8eECZ4kX++n9GSrw5AaHLqnOg0PPXaJS2?=
 =?us-ascii?Q?ZmLdx4iSExcObhGWWdXUc1DU3zLd5HiYmAmslSlCgA8QhTqCj?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0607;6:f/fVMSWCOCHP7yKXfc1ms9XGOmo76as1lspa4iy61Xw0zW788mPeNC7EDJqKW3QnZprfKOY9zDEuhRFL1iZ7GwGwiavydlmp7f46T+UEHgmQ9uSbsi9Bkk0EAgBkEp2XuImwl7lFAibc4AR++H2VfFKSSjBiOlN9DueUjZkzi4z3sxBYh+Ve84Hj2HRhPaupVdpe8om5EP+knITsQWNM4rpR/D/Ajb3HUgHmpObZxj1zr9KuRJDE8DI32lARmSNuXZU0PSjo/8wTeUysaD2wutkR7y1WGC6zY7yc1vVvHCvFlrfl46zUWAfeUFqLRLx8SuZNWMbGpulxK+x4pMC58CtwChRqYFFaZeHnodwZZ64=;5:S/5fUunsR2dSDGTfYCKVbT2bAn0uCm15nhg/4C4ye3p2yf7UCckaw6h7zxBqzuEM9yPf55etLudY2ICYhK3gjQCSRnoHcs4NrC+64Kcm7SOQzQD76KDhTybaEwLDKArFLEjVQxVoH8kPUyZAbOzotDaf5+R31oaHziVHMFl4UUc=;24:NeGfCXFp703O5nbDztIN9xqQJ70dNwDSEZnnZ1Qj17Vqom/eW4DQdSd0SL2JSU74xVh8Ed2yRuNKwapt9wJ/5CadA1Ui3FXQ1IFnyGV9ZlY=;7:Z2SE5Z3Ska18F+BB57JzLhW22/RIoj5BHtR4FCx0/cHMLWP7BT9oXo6GGTdfkUM5yLYKKfnDHGrO6n8CBGnpmXbcwIOG2e5vL/7zYWMaE75gMxHkD+J3An9G5oXgvL4AUrETw/9KXrKNl9hywrArSI8uViatmb0YxbO7LmQxOQkaKqtZ3B0GRn4G81+I8BmL+2K1VyL/cQkWSI1PhAE109K4BZFhcmiB8pygBpesMMHByB+L0lJuc9H6cP8b7ZPP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 04:21:04.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998900ec-b72b-46d9-7600-08d56de243bf
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0301MB0607
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590494846034483631?=
X-GMAIL-MSGID: =?utf-8?q?1591714557846876368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 04:50:41PM +0100, Sebastian Reichel wrote:
> Hi Peter,
> 
> On Mon, Jan 29, 2018 at 11:33:15AM +0800, Peter Chen wrote:
> > On Wed, Jan 24, 2018 at 06:14:39PM +0100, Sebastian Reichel wrote:
> > > Traditionally, PORTSC should be set before initializing ULPI phys. But
> > > setting PORTSC before powering on the phy results in a kernel freeze
> > > on imx53 based GE PPD. As a workaround this initializes the phy early
> > > in the imx platform code and disables phy power management from the
> > > core.
> > > 
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > ---
> > >  drivers/usb/chipidea/ci_hdrc_imx.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > > index de155c80eb70..e431c5aafe35 100644
> > > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > > @@ -83,6 +83,7 @@ struct ci_hdrc_imx_data {
> > >  	struct clk *clk;
> > >  	struct imx_usbmisc_data *usbmisc_data;
> > >  	bool supports_runtime_pm;
> > > +	bool override_phy_control;
> > >  	bool in_lpm;
> > >  	/* SoC before i.mx6 (except imx23/imx28) needs three clks */
> > >  	bool need_three_clks;
> > > @@ -254,6 +255,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> > >  	int ret;
> > >  	const struct of_device_id *of_id;
> > >  	const struct ci_hdrc_imx_platform_flag *imx_platform_flag;
> > > +	struct device_node *np = pdev->dev.of_node;
> > >  
> > >  	of_id = of_match_device(ci_hdrc_imx_dt_ids, &pdev->dev);
> > >  	if (!of_id)
> > > @@ -288,6 +290,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	pdata.usb_phy = data->phy;
> > > +
> > > +	if (of_device_is_compatible(np, "fsl,imx53-usb") && pdata.usb_phy &&
> > > +	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
> > > +		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
> > > +		data->override_phy_control = true;
> > > +		usb_phy_init(pdata.usb_phy);
> > > +	}
> > > +
> > >  	pdata.flags |= imx_platform_flag->flags;
> > >  	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
> > >  		data->supports_runtime_pm = true;
> > > @@ -341,6 +351,8 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
> > >  		pm_runtime_put_noidle(&pdev->dev);
> > >  	}
> > >  	ci_hdrc_remove_device(data->ci_pdev);
> > > +	if (data->override_phy_control)
> > > +		usb_phy_shutdown(data->phy);
> > >  	imx_disable_unprepare_clks(&pdev->dev);
> > >  
> > 
> > Sebastian, I have a question, do you have any USB or generic PHY drivers
> > for ULPI bus, any power controls are needed for your ULPI peripheral?
> 
> The devicetree for GE PPD is available in the mainline kernel:
> 
> $ grep -A9 "usbphy[23] {" arch/arm/boot/dts/imx53-ppd.dts
> 	usbphy2: usbphy2 {
> 		compatible = "usb-nop-xceiv";
> 		reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
> 		clock-names = "main_clk";
> 		clock-frequency = <24000000>;
> 		clocks = <&clks IMX5_CLK_CKO2>;
> 		assigned-clocks = <&clks IMX5_CLK_CKO2_SEL>, <&clks IMX5_CLK_OSC>;
> 		assigned-clock-parents = <&clks IMX5_CLK_OSC>;
> 	};
> 
> 	usbphy3: usbphy3 {
> 		compatible = "usb-nop-xceiv";
> 		reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
> 		clock-names = "main_clk";
> 
> 		clock-frequency = <24000000>;
> 		clocks = <&clks IMX5_CLK_CKO2>;
> 		assigned-clocks = <&clks IMX5_CLK_CKO2_SEL>, <&clks IMX5_CLK_OSC>;
> 		assigned-clock-parents = <&clks IMX5_CLK_OSC>;
> 	};
> 
> So currently the machine only uses drivers/usb/phy/phy-generic.c. Both
> USB phys are actually SMSC USB3315, which is also detected by the kernel:
> 
> root@csmon :~# cat /sys/bus/ulpi/devices/ci_hdrc.*.ulpi/uevent 
> DEVTYPE=ulpi_device
> MODALIAS=ulpi:v0424p0006
> DEVTYPE=ulpi_device
> MODALIAS=ulpi:v0424p0006
> 
> So maybe drivers/usb/phy/phy-ulpi.c should be used, but I don't see
> a simple way to do so and using the generic PHY works.
> 

It is correct you use phy-generic.c if it can let your design
work, thanks.

-- 

Best Regards,
Peter Chen
