Return-Path: <jun.li@nxp.com>
X-Cyrus-Session-Id: sloti22d1t05-3535774-1520829228-2-14474477881125830811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H4 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES roensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.2.55',
  Host='mail-db5eur01on0055.outbound.protection.outlook.com', Country='IE',
  FromHeader='com', MailFrom='com', XOriginatingCountry='SG'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jun.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520829228; b=gmZwndHaza9np1ZDsIwhNXDZRNeQXZmIFyvKVEDUWh8p6uD
    ncwoPP35pIn/AIzyU+fmOdAeP8t4JYRyTETeb1UETs9/syofncbIuHUlw3LDYS5w
    lnWQw5VKvTq+HvpdLbahYGpVeNvnT6Oz+s5yG1GtmbdJuEthmcDLbHKSrABwZQuN
    /CPowZ1o6Qlm02ZFChlrlEGtjpVrNHjILvs7c4wvWrSiW+ZKwMaYU6FUV29+Toj9
    +pFeGLvPBw0kXG1ZalW5MADG8UTIXX+W6k/AFBTEvRLJn0YlhryzGlQLJ17q1Mo4
    wd/Xqtwgi3CKl+GhaVQAAZB9pZ88APgYDAngFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=arctest; t=1520829228; bh=X7S4AQffQdPu6X8yhnaEK
    2uCUMVOSkStQFEpyy6U56I=; b=l1r9L9UV6JVhtbIHBESkHIdzeDRejv1lMXgPC
    4C9QXtxw1ernCowNEq2YYfw43/1VOWM6qMsmIzAfD63n/ltBY0SoOf7yOwEdl1yW
    yslaDCLpn5pS+POsaGjrsUv/AMAZq51N7NlwVkiSnxltj73OgeCACZZXfJZu8JHN
    K5GscfDZhAwdFFs0s3aVnYr9CNaRqSHD4fKdf0dphMuoEy/nvMvsCgzax4WeazTJ
    g6yXrrCLOqNARfTQifIh7iuk2uVZOxzr3yqtDzoKEt1F7xYqbFRX2b06gXEbVBs0
    qYk+FOVlMeHLCl7fr2WdbHaTTxijqPD8HxOpeflLothMOa7ZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=F+OtNRJ7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=104.47.2.55 (mail-db5eur01on0055.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=jun.li@nxp.com smtp.helo=EUR01-DB5-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=EUR01-DB5-obe.outbound.protection.outlook.com x-ptr-lookup=mail-db5eur01on0055.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=nxp.com smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=F+OtNRJ7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=104.47.2.55 (mail-db5eur01on0055.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=jun.li@nxp.com smtp.helo=EUR01-DB5-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=EUR01-DB5-obe.outbound.protection.outlook.com x-ptr-lookup=mail-db5eur01on0055.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=nxp.com smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
From: Jun Li <jun.li@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ShuFan Lee
	<leechu729@gmail.com>, "heikki.krogerus@linux.intel.com"
	<heikki.krogerus@linux.intel.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"greg@kroah.com" <greg@kroah.com>
CC: "shufan_lee@richtek.com" <shufan_lee@richtek.com>, "cy_huang@richtek.com"
	<cy_huang@richtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: [PATCH v7] staging: typec: handle vendor defined part and modify
 drp toggling flow
Thread-Topic: [PATCH v7] staging: typec: handle vendor defined part and modify
 drp toggling flow
Thread-Index: AQHTtO2TvuhbiKnCtkaCXDhq065ky6PL/wvQ
Date: Mon, 12 Mar 2018 04:33:41 +0000
Message-ID: <VI1PR0402MB39170322F313A03DC0018A8089D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
In-Reply-To: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2846;7:UGcX7lQefmVHJw0zj5gdd0PXVWFtpUstp8jsj9Fa+U12RStv19hKvCnkwvN1smkHZLNNM87qa44kLVg1mJ4iE5nSwqQbBY9uVyI/vBFnPr5MWMI4B5KgH2MxERQMZNBnEb2vofnW7I7bszEJzTlhIh/gl3qlJsu6sftiO0luRB6k6JGJYru3bAU0Rt5g8hpz+++oJioznVC4f09OF9magS+UuFFnrW4avvAYjprK4Qc3xWHnjgTznSLsweeqlR5C
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83e7d867-d457-44b4-e18d-08d587d26ea5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2846;
x-ms-traffictypediagnostic: VI1PR0402MB2846:
x-microsoft-antispam-prvs: <VI1PR0402MB2846E5F57B0C70B1697EA23B89D30@VI1PR0402MB2846.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0402MB2846;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2846;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(86362001)(8936002)(2950100002)(59450400001)(8676002)(81156014)(2201001)(14454004)(25786009)(39060400002)(6116002)(3846002)(66066001)(4326008)(478600001)(2906002)(3280700002)(99286004)(2900100001)(97736004)(3660700001)(186003)(26005)(102836004)(966005)(6506007)(5660300001)(81166006)(7736002)(575784001)(305945005)(53936002)(2501003)(5250100002)(106356001)(6246003)(7696005)(68736007)(105586002)(110136005)(76176011)(74316002)(33656002)(54906003)(6436002)(316002)(55016002)(6306002)(229853002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2846;H:VI1PR0402MB3917.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jpijm+ViDLIY0s4bVTCJyMm6lMuctmogmcUhbdZ9BdFZk3jtk0t4ZHU93ME2kHK+/7G5TXX6phtW8uZTJbPM0233fwUFKrs5kRAfVEOLMFq2DSoYnDgJmIdPdM60h9UUbpbRMcJFaRTIcuBxllZ5MQI0CL4eDICT3V9IZhbhDr84b7qpRCnhRubs82qAfQjhYVjcV9EUb1TWFF9DkNln4QA7UvDgZgoXF8O3Ln6U1+lnaeOJPUa0LpcJQY2LFTwK+tedYr9366W6Nyf26ukAnTcFivFyZitMoWBVhxpIdWNTX3nlz8xku8GIpn1wUW1AHkkKV1jqIpkhPVVRmgp7Rw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e7d867-d457-44b4-e18d-08d587d26ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 04:33:41.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2846
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

> +static irqreturn_t _tcpci_irq(int irq, void *dev_id) {
> +	struct tcpci *tcpci =3D dev_id;
> +
> +	return tcpci_irq(tcpci);
> +}
>=20
...

> +	err =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					_tcpci_irq,
>  					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -					dev_name(tcpci->dev), tcpci);
> +					dev_name(&client->dev), chip);

- dev_name(&client->dev), chip);
+ dev_name(&client->dev), chip->tcpci);=20

Did you ever test this patch?

I noticed Greg already picked this patch[1]:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?=
h=3Dusb-testing&id=3D8f94390226487bcb86c554ddc12eef0d27bdec3b

One more minor comment below.

Jun Li

> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.=
h index
> fdfb06c..a2c1754 100644
> --- a/drivers/staging/typec/tcpci.h
> +++ b/drivers/staging/typec/tcpci.h
> @@ -59,6 +59,7 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>=20
>  #define TCPC_CC_STATUS			0x1d
> +#define TCPC_CC_STATUS_DRPRST		BIT(5)

Defined but not used.

>  #define TCPC_CC_STATUS_TERM		BIT(4)
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
> @@ -121,4 +122,18 @@
>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
>=20
> +struct tcpci;
> +struct tcpci_data {
> +	struct regmap *regmap;
> +	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> +	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> +			 bool enable);
> +	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
> +				  enum typec_cc_status cc);
> +};
> +
> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data
> +*data); void tcpci_unregister_port(struct tcpci *tcpci); irqreturn_t
> +tcpci_irq(struct tcpci *tcpci);
> +
>  #endif /* __LINUX_USB_TCPCI_H */
> --
> 1.9.1
