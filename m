Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7DC2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7DC2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeHWWBU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:01:20 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:41588 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHWWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:01:19 -0400
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 0693E1DED
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 18:30:23 +0000 (UTC)
Received: from G4W9122.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 45C987A;
        Thu, 23 Aug 2018 18:30:22 +0000 (UTC)
Received: from G4W9122.americas.hpqcorp.net (2002:10d2:1511::10d2:1511) by
 G4W9122.americas.hpqcorp.net (2002:10d2:1511::10d2:1511) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 23 Aug 2018 18:30:22 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9122.americas.hpqcorp.net (16.210.21.17) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 23 Aug 2018 18:30:21 +0000
Received: from TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM (10.169.42.148) by
 TU4PR8401MB0493.NAMPRD84.PROD.OUTLOOK.COM (10.169.43.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 23 Aug 2018 18:30:20 +0000
Received: from TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5df9:92f5:7a37:fb94]) by TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5df9:92f5:7a37:fb94%4]) with mapi id 15.20.1080.015; Thu, 23 Aug 2018
 18:30:20 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     Corey Minyard <cminyard@mvista.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ipmi: Rework SMI registration failure
Thread-Topic: [PATCH] ipmi: Rework SMI registration failure
Thread-Index: AQHUOjx/umPzfcF3aEaCX+QW8wj3OaTNqdDQ
Date:   Thu, 23 Aug 2018 18:30:20 +0000
Message-ID: <TU4PR8401MB03828F31D13FDD425974507487370@TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM>
References: <1534958412-27199-1-git-send-email-minyard@acm.org>
In-Reply-To: <1534958412-27199-1-git-send-email-minyard@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=justin.ernst@hpe.com; 
x-originating-ip: [15.203.227.12]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TU4PR8401MB0493;6:AqIAz2S+oj45YyxVzuJXrmadaqcuvQirWxts04oki1LznAZC2IsX/MYubR9SUW9BWKu8xj5GrU/mQKAg4kJoeMrnAHtt6OKdsLTemurN5v4wLkdyDerRQ5mmUzytL1SBOFw/Axx55kW7hquwvne24QoQcyO/brHxqM6ZDywT77GRz5Sfja6OMl5cCnLwk9QAU1HhBKfbyatAiaxXN3B0IbGhywTSuXDic7tj+ozIfX+F0Owfni5JGOv7Z2dh+KWcVmQ+ehMTYS7LXKWGBLKXcst9yXSrgM4DcwWyVUHq5sqyUhCOqD4390L2ZST7zJwuBgg0J8VceTOxPf0eTxFz/BAzGMCzTKhRgohSf+0lYq6eHSp3qRW1ofzHVfuZ3y6pnoKg25/6zc1Li7MIAek9esGdH72ZGGCpkzoCVi6jrXFsB4tKri+gniI0W1cyIwkLH0Eti8BeRcbR8UatIjkYZA==;5:2Qxjbq6STsu7liYarGw10tg5sN3fzziAJQJA/GsG1TSzWDG3lLjzwKrqqO5NEr6XhZOZQMiZq6a4xr0L9xxVwJgpH0inowvR3k7MuryPhKCRRH2mNG8c1h5gUWOsZZcT4w+cRVtlWvzwRMJ3VTl5qGBvMxgFiS1T6JOI8rdr5/A=;7:eYqti17xib5zsNDtwYgmfpJY6f+6DpNcIVeU38KN2ul8k4epsIoU3T/6venOwmfNQM1kCxWrtA3Faicnz6kQGyo5zk8Gm4Nlp/pFJ825lPwmKtef3flrLapQzMFa961v/KN4vrfWaDx4zjEaJK9vjcyGWb3x+Q/KsvXeRl8M3TXk19knRv6viSfh0n45ADB+Umlc/mirC3lP4x7m4KtfiWupITjQK0EOyu6zqw4Rql3MsyLObhU4YG1nTDIVn3SY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(189003)(199004)(13464003)(229853002)(5660300001)(6916009)(81166006)(316002)(55016002)(33656002)(4326008)(6436002)(9686003)(1730700003)(81156014)(5640700003)(25786009)(53936002)(8936002)(86362001)(2906002)(66066001)(2501003)(68736007)(97736004)(5250100002)(6246003)(105586002)(106356001)(2900100001)(2351001)(256004)(26005)(186003)(3846002)(6116002)(99286004)(7736002)(486006)(14444005)(478600001)(74316002)(305945005)(476003)(11346002)(446003)(76176011)(6506007)(14454004)(8676002)(102836004)(7696005)(53546011)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0493;H:TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e1ec059f-f1c3-4a5b-f45b-08d609267b78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0493;
x-ms-traffictypediagnostic: TU4PR8401MB0493:
x-microsoft-antispam-prvs: <TU4PR8401MB04939FA0A42FFDB2677FDFB887370@TU4PR8401MB0493.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(143289334528602)(227479698468861)(9452136761055)(85827821059158)(42262312472803)(213716511872227)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:TU4PR8401MB0493;BCL:0;PCL:0;RULEID:;SRVR:TU4PR8401MB0493;
x-forefront-prvs: 0773BB46AC
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fjbPTh2EJOKaXkM/4b5N0Yw5IsSqLklet34ZCwJkimbliMywc4m9NPSG1+i5sqYlkUGTZmoFVcrpesHjTXib2rUOx4apGCps43L8r3mWwX9cj2cNUzf+D6SqA/i/Jp50sK07ZB/srQ09GBuDm2Fi7730l5a1OostpmXy8Vzkdc/TW/wLj0YtHXE3YO4BEkFIMMzN59hiB3sDeNDLpiXpr1gPcP/tY6UAugr6bI5SPkkjWA8252V5gxiy2ZLyEEf8HDo9xsTshcBJRKJxKFyX1iKg/DkS5JQmJ9f59XNQBup1pFANyF/neoBRuHJiCx7Rncof+zCc3tYIhc2yIuF3meRe5E4nQV58QXaZ5ObHxj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ec059f-f1c3-4a5b-f45b-08d609267b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 18:30:20.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0493
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Justin Ernst <justin.ernst@hpe.com>

Passed the testing. Thanks Corey!
-Justin

> -----Original Message-----
> From: Corey Minyard [mailto:tcminyard@gmail.com] On Behalf Of
> minyard@acm.org
> Sent: Wednesday, August 22, 2018 12:20 PM
> To: Ernst, Justin <justin.ernst@hpe.com>
> Cc: Corey Minyard <cminyard@mvista.com>; Banman, Andrew
> <abanman@hpe.com>; Anderson, Russ <russ.anderson@hpe.com>;
> openipmi-developer@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: [PATCH] ipmi: Rework SMI registration failure
> 
> From: Corey Minyard <cminyard@mvista.com>
> 
> There were certain situations where ipmi_register_smi() would return a
> failure, but the interface would still be registered and would need to be
> unregistered.  This is obviously a bad design and resulted in an oops in certain
> failure cases.
> 
> If the interface is started up in ipmi_register_smi(), then an error occurs, shut
> down the interface there so the cleanup can be done properly.
> 
> Fix the various smi users, too.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reported-by: Justin Ernst <justin.ernst@hpe.com>
> Cc: Andrew Banman <abanman@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 53 +++++++++++++++++++++--------
> --------
>  drivers/char/ipmi/ipmi_si_intf.c    | 17 +++---------
>  drivers/char/ipmi/ipmi_ssif.c       | 13 +++------
>  3 files changed, 37 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c
> b/drivers/char/ipmi/ipmi_msghandler.c
> index 46ab1ba..04f64c5 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3378,39 +3378,45 @@ int ipmi_register_smi(const struct
> ipmi_smi_handlers *handlers,
> 
>  	rv = handlers->start_processing(send_info, intf);
>  	if (rv)
> -		goto out;
> +		goto out_err;
> 
>  	rv = __bmc_get_device_id(intf, NULL, &id, NULL, NULL, i);
>  	if (rv) {
>  		dev_err(si_dev, "Unable to get the device id: %d\n", rv);
> -		goto out;
> +		goto out_err_started;
>  	}
> 
>  	mutex_lock(&intf->bmc_reg_mutex);
>  	rv = __scan_channels(intf, &id);
>  	mutex_unlock(&intf->bmc_reg_mutex);
> +	if (rv)
> +		goto out_err_bmc_reg;
> 
> - out:
> -	if (rv) {
> -		ipmi_bmc_unregister(intf);
> -		list_del_rcu(&intf->link);
> -		mutex_unlock(&ipmi_interfaces_mutex);
> -		synchronize_srcu(&ipmi_interfaces_srcu);
> -		cleanup_srcu_struct(&intf->users_srcu);
> -		kref_put(&intf->refcount, intf_free);
> -	} else {
> -		/*
> -		 * Keep memory order straight for RCU readers.  Make
> -		 * sure everything else is committed to memory before
> -		 * setting intf_num to mark the interface valid.
> -		 */
> -		smp_wmb();
> -		intf->intf_num = i;
> -		mutex_unlock(&ipmi_interfaces_mutex);
> +	/*
> +	 * Keep memory order straight for RCU readers.  Make
> +	 * sure everything else is committed to memory before
> +	 * setting intf_num to mark the interface valid.
> +	 */
> +	smp_wmb();
> +	intf->intf_num = i;
> +	mutex_unlock(&ipmi_interfaces_mutex);
> 
> -		/* After this point the interface is legal to use. */
> -		call_smi_watchers(i, intf->si_dev);
> -	}
> +	/* After this point the interface is legal to use. */
> +	call_smi_watchers(i, intf->si_dev);
> +
> +	return 0;
> +
> + out_err_bmc_reg:
> +	ipmi_bmc_unregister(intf);
> + out_err_started:
> +	if (intf->handlers->shutdown)
> +		intf->handlers->shutdown(intf->send_info);
> + out_err:
> +	list_del_rcu(&intf->link);
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +	synchronize_srcu(&ipmi_interfaces_srcu);
> +	cleanup_srcu_struct(&intf->users_srcu);
> +	kref_put(&intf->refcount, intf_free);
> 
>  	return rv;
>  }
> @@ -3501,7 +3507,8 @@ void ipmi_unregister_smi(struct ipmi_smi *intf)
>  	}
>  	srcu_read_unlock(&intf->users_srcu, index);
> 
> -	intf->handlers->shutdown(intf->send_info);
> +	if (intf->handlers->shutdown)
> +		intf->handlers->shutdown(intf->send_info);
> 
>  	cleanup_smi_msgs(intf);
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 2194b4c..bb7d8af 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2102,18 +2102,9 @@ static int try_smi_init(struct smi_info *new_smi)
>  		 si_to_str[new_smi->io.si_type]);
> 
>  	WARN_ON(new_smi->io.dev->init_name != NULL);
> -	kfree(init_name);
> -
> -	return 0;
> -
> -out_err:
> -	if (new_smi->intf) {
> -		ipmi_unregister_smi(new_smi->intf);
> -		new_smi->intf = NULL;
> -	}
> 
> + out_err:
>  	kfree(init_name);
> -
>  	return rv;
>  }
> 
> @@ -2246,6 +2237,8 @@ static void shutdown_smi(void *send_info)
> 
>  	kfree(smi_info->si_sm);
>  	smi_info->si_sm = NULL;
> +
> +	smi_info->intf = NULL;
>  }
> 
>  /*
> @@ -2259,10 +2252,8 @@ static void cleanup_one_si(struct smi_info
> *smi_info)
> 
>  	list_del(&smi_info->link);
> 
> -	if (smi_info->intf) {
> +	if (smi_info->intf)
>  		ipmi_unregister_smi(smi_info->intf);
> -		smi_info->intf = NULL;
> -	}
> 
>  	if (smi_info->pdev) {
>  		if (smi_info->pdev_registered)
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index fddf646..3574322 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1218,18 +1218,11 @@ static void shutdown_ssif(void *send_info)
>  		complete(&ssif_info->wake_thread);
>  		kthread_stop(ssif_info->thread);
>  	}
> -
> -	/*
> -	 * No message can be outstanding now, we have removed the
> -	 * upper layer and it permitted us to do so.
> -	 */
> -	kfree(ssif_info);
>  }
> 
>  static int ssif_remove(struct i2c_client *client)  {
>  	struct ssif_info *ssif_info = i2c_get_clientdata(client);
> -	struct ipmi_smi *intf;
>  	struct ssif_addr_info *addr_info;
> 
>  	if (!ssif_info)
> @@ -1239,9 +1232,7 @@ static int ssif_remove(struct i2c_client *client)
>  	 * After this point, we won't deliver anything asychronously
>  	 * to the message handler.  We can unregister ourself.
>  	 */
> -	intf = ssif_info->intf;
> -	ssif_info->intf = NULL;
> -	ipmi_unregister_smi(intf);
> +	ipmi_unregister_smi(ssif_info->intf);
> 
>  	list_for_each_entry(addr_info, &ssif_infos, link) {
>  		if (addr_info->client == client) {
> @@ -1250,6 +1241,8 @@ static int ssif_remove(struct i2c_client *client)
>  		}
>  	}
> 
> +	kfree(ssif_info);
> +
>  	return 0;
>  }
> 
> --
> 2.7.4

