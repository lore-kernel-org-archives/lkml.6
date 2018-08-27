Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A74F208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A74F208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeH1AEz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:04:55 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:8095 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1AEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:04:55 -0400
Received: from G9W8456.americas.hpqcorp.net (g9w8456.houston.hp.com [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id ADB6963;
        Mon, 27 Aug 2018 20:16:46 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 27 Aug 2018 20:16:46 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 27 Aug 2018 20:16:46 +0000
Received: from TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM (10.169.43.15) by
 TU4PR8401MB0397.NAMPRD84.PROD.OUTLOOK.COM (10.169.42.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Mon, 27 Aug 2018 20:16:44 +0000
Received: from TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2995:a39:a0a2:3158]) by TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2995:a39:a0a2:3158%8]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 20:16:43 +0000
From:   "Banman, Andrew" <abanman@hpe.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "Ramsay, Frank" <frank.ramsay@hpe.com>,
        "Ernst, Justin" <justin.ernst@hpe.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: RE: [PATCH 1/2] ipmi: Move BT capabilities detection to the detect
 call
Thread-Topic: [PATCH 1/2] ipmi: Move BT capabilities detection to the detect
 call
Thread-Index: AQHUOyEfRq+wlD+DEU2qdfapZpi27qTUD2Hw
Date:   Mon, 27 Aug 2018 20:16:43 +0000
Message-ID: <TU4PR8401MB0430BCEBB2F6C81611054555A60B0@TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM>
References: <1535056623-26634-1-git-send-email-minyard@acm.org>
 <1535056623-26634-2-git-send-email-minyard@acm.org>
In-Reply-To: <1535056623-26634-2-git-send-email-minyard@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abanman@hpe.com; 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TU4PR8401MB0397;6:geC8rhZvPfX2uMbbAnpTUfkcFRqy8IXnQiFlvlCmzi/Ica9wqI1UfkEjM9rT4/exSnG9sn3lALHBry5v6jA9D447Ss3IRefufvjKgIh0JpbiOMvrCn888x8TwceH/LGxA53R5FUrKFZ9KaJU9LbzZyIJ6OCOheFNCbCaDq4AhoRRuA5/KXs+y1fMT1aN4jjqw/akaKPZwIUPnkhblilV8nRmyWEVLYsmb1IqKgMCjTf6GQBH4DmI+RJeATYwyEL+4W7md4Zveyn/dWplcWTMtyUF23etK6pdiZ9HE0Ff3+ZTvTX1gnIx507iDI1J52Bf3HcbjoYmUtn4v8oqG27H8W7dN1P3+lnicL/FJx01Y9k4gTD7dweW6o56CJTxb/vdrX0t+SSSe+BfatgIEPNZAfsfhWptraWxjICQAjx37qLRVX0lBnoyGUTzvijqptoZHx6It7scY4ne+2FkZpPKmA==;5:JAc5cvYeAV0PhEXI4tJHSbav/WNgq5Y5XTCCHngoxj119n4bB3tvuVqzePkvnGJZlQsYyKmiRscaFMVAPP/ajDjUPTTfve55ADVPztLbFhW1YW12jRAazue7TEKgO/i1244/bc3Q+O+h6CKg9bFaV6y+uCooJ3OuCdWls1g6ghk=;7:pRSu90gwIXAelgpIVdPvvEkQCzOh9oKc2q8j0ERUOWnaGgJ8qTHst923hyEMCatnDCsBPTnlwxiWxG3N6LuzKUvl9nxBHMNGewmKse7+GFY6NZJr4TX5EPTUri8I+145OBzhQtIwtObmlXaf7VWACFw+A2AR2TSKid8oLup7bbyGKHiSkP6/kvufKgW1P22oPnsObJWP/8sVdlg3qHh1qXi0e7s8PLcMAI4LGU4WXlNQxNkrbX3kLx4nbw1C21zi
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(39860400002)(366004)(13464003)(189003)(199004)(5660300001)(99286004)(53546011)(6506007)(66066001)(97736004)(6916009)(186003)(551934003)(33656002)(102836004)(2906002)(76176011)(26005)(7736002)(305945005)(8676002)(74316002)(7696005)(2900100001)(229853002)(81166006)(3846002)(6116002)(68736007)(2351001)(4326008)(106356001)(105586002)(8936002)(25786009)(1730700003)(81156014)(55016002)(6246003)(53936002)(54906003)(6436002)(316002)(9686003)(5250100002)(5640700003)(256004)(2501003)(14444005)(486006)(86362001)(11346002)(476003)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0397;H:TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 508eb10e-9565-4afc-a7bd-08d60c5a0192
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0397;
x-ms-traffictypediagnostic: TU4PR8401MB0397:
x-microsoft-antispam-prvs: <TU4PR8401MB03972F23C4170B8B71D8794BA60B0@TU4PR8401MB0397.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(143289334528602)(227479698468861)(9452136761055)(85827821059158)(42262312472803)(213716511872227)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:TU4PR8401MB0397;BCL:0;PCL:0;RULEID:;SRVR:TU4PR8401MB0397;
x-forefront-prvs: 07778E4001
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a488aEROIFrZE12Y6AWx78GZCngl5EJlpjgKKF8FLiWFq7kk16WJ5MxPaZVsRPyHs2ZO3Kv13SIT+0IgCyDEymDgEpx4bJu3WLS2APqm/fLmrSXLBbIMJ0/n0kDQlYC7zbBkK7m5ZdwtXnW2yjFw/mRiJMR/Fmec4s5ePg7FlijgjXyVzTu9NMXPiHNLbAQfZNPOpUmVLrweuRD/Ggk1XSrmcco9Qd7hwoTQASlkhZXEEFyOXLxTtbCIjuzWMpurAUxTjmKIxIpkxwE3K2lW/FCf33Xhc3nTTN0SlpqlWSN/KYoAEDlyOOBbSZFdkkLKMwgHrDmH52lDZebFALQ/IRGK6RMhYH9V/WIcI52MLys=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 508eb10e-9565-4afc-a7bd-08d60c5a0192
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 20:16:43.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0397
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Andrew Banman

Ran through 100+ boots with no error with your 1st patch applied. I don't see any endcases to worry about.

Thanks Corey!

Andrew

> -----Original Message-----
> From: Corey Minyard [mailto:tcminyard@gmail.com] On Behalf Of
> minyard@acm.org
> Sent: Thursday, August 23, 2018 3:37 PM
> To: Banman, Andrew <abanman@hpe.com>
> Cc: openipmi-developer@lists.sourceforge.net; linux-
> kernel@vger.kernel.org; Anderson, Russ <russ.anderson@hpe.com>; Ramsay,
> Frank <frank.ramsay@hpe.com>; Ernst, Justin <justin.ernst@hpe.com>;
> Corey Minyard <cminyard@mvista.com>
> Subject: [PATCH 1/2] ipmi: Move BT capabilities detection to the detect
> call
> 
> From: Corey Minyard <cminyard@mvista.com>
> 
> The capabilities detection was being done as part of the normal
> state machine, but it was possible for it to be running while
> the upper layers of the IPMI driver were initializing the
> device, resulting in error and failure to initialize.
> 
> Move the capabilities detection to the the detect function,
> so it's done before anything else runs on the device.  This also
> simplifies the state machine and removes some code, as a bonus.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reported-by: Andrew Banman <abanman@hpe.com>
> ---
>  drivers/char/ipmi/ipmi_bt_sm.c | 92 ++++++++++++++++++++++-------------
> -------
>  1 file changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_bt_sm.c
> b/drivers/char/ipmi/ipmi_bt_sm.c
> index cbc6126..b4133832e 100644
> --- a/drivers/char/ipmi/ipmi_bt_sm.c
> +++ b/drivers/char/ipmi/ipmi_bt_sm.c
> @@ -59,8 +59,6 @@ enum bt_states {
>  	BT_STATE_RESET3,
>  	BT_STATE_RESTART,
>  	BT_STATE_PRINTME,
> -	BT_STATE_CAPABILITIES_BEGIN,
> -	BT_STATE_CAPABILITIES_END,
>  	BT_STATE_LONG_BUSY	/* BT doesn't get hosed :-) */
>  };
> 
> @@ -86,7 +84,6 @@ struct si_sm_data {
>  	int		error_retries;	/* end of "common" fields */
>  	int		nonzero_status;	/* hung BMCs stay all 0 */
>  	enum bt_states	complete;	/* to divert the state machine */
> -	int		BT_CAP_outreqs;
>  	long		BT_CAP_req2rsp;
>  	int		BT_CAP_retries;	/* Recommended retries */
>  };
> @@ -137,8 +134,6 @@ static char *state2txt(unsigned char state)
>  	case BT_STATE_RESET3:		return("RESET3");
>  	case BT_STATE_RESTART:		return("RESTART");
>  	case BT_STATE_LONG_BUSY:	return("LONG_BUSY");
> -	case BT_STATE_CAPABILITIES_BEGIN: return("CAP_BEGIN");
> -	case BT_STATE_CAPABILITIES_END:	return("CAP_END");
>  	}
>  	return("BAD STATE");
>  }
> @@ -185,7 +180,6 @@ static unsigned int bt_init_data(struct si_sm_data
> *bt, struct si_sm_io *io)
>  	bt->complete = BT_STATE_IDLE;	/* end here */
>  	bt->BT_CAP_req2rsp = BT_NORMAL_TIMEOUT * USEC_PER_SEC;
>  	bt->BT_CAP_retries = BT_NORMAL_RETRY_LIMIT;
> -	/* BT_CAP_outreqs == zero is a flag to read BT Capabilities */
>  	return 3; /* We claim 3 bytes of space; ought to check SPMI table
> */
>  }
> 
> @@ -447,7 +441,7 @@ static enum si_sm_result error_recovery(struct
> si_sm_data *bt,
> 
>  static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
>  {
> -	unsigned char status, BT_CAP[8];
> +	unsigned char status;
>  	static enum bt_states last_printed = BT_STATE_PRINTME;
>  	int i;
> 
> @@ -500,12 +494,6 @@ static enum si_sm_result bt_event(struct si_sm_data
> *bt, long time)
>  		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
>  			BT_CONTROL(BT_H_BUSY);
> 
> -		bt->timeout = bt->BT_CAP_req2rsp;
> -
> -		/* Read BT capabilities if it hasn't been done yet */
> -		if (!bt->BT_CAP_outreqs)
> -			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
> -					SI_SM_CALL_WITHOUT_DELAY);
>  		BT_SI_SM_RETURN(SI_SM_IDLE);
> 
>  	case BT_STATE_XACTION_START:
> @@ -610,37 +598,6 @@ static enum si_sm_result bt_event(struct si_sm_data
> *bt, long time)
>  		BT_STATE_CHANGE(BT_STATE_XACTION_START,
>  				SI_SM_CALL_WITH_DELAY);
> 
> -	/*
> -	 * Get BT Capabilities, using timing of upper level state machine.
> -	 * Set outreqs to prevent infinite loop on timeout.
> -	 */
> -	case BT_STATE_CAPABILITIES_BEGIN:
> -		bt->BT_CAP_outreqs = 1;
> -		{
> -			unsigned char GetBT_CAP[] = { 0x18, 0x36 };
> -			bt->state = BT_STATE_IDLE;
> -			bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
> -		}
> -		bt->complete = BT_STATE_CAPABILITIES_END;
> -		BT_STATE_CHANGE(BT_STATE_XACTION_START,
> -				SI_SM_CALL_WITH_DELAY);
> -
> -	case BT_STATE_CAPABILITIES_END:
> -		i = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
> -		bt_init_data(bt, bt->io);
> -		if ((i == 8) && !BT_CAP[2]) {
> -			bt->BT_CAP_outreqs = BT_CAP[3];
> -			bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
> -			bt->BT_CAP_retries = BT_CAP[7];
> -		} else
> -			pr_warn("IPMI BT: using default values\n");
> -		if (!bt->BT_CAP_outreqs)
> -			bt->BT_CAP_outreqs = 1;
> -		pr_warn("IPMI BT: req2rsp=%ld secs retries=%d\n",
> -			bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
> -		bt->timeout = bt->BT_CAP_req2rsp;
> -		return SI_SM_CALL_WITHOUT_DELAY;
> -
>  	default:	/* should never occur */
>  		return error_recovery(bt,
>  				      status,
> @@ -651,6 +608,11 @@ static enum si_sm_result bt_event(struct si_sm_data
> *bt, long time)
> 
>  static int bt_detect(struct si_sm_data *bt)
>  {
> +	unsigned char GetBT_CAP[] = { 0x18, 0x36 };
> +	unsigned char BT_CAP[8];
> +	enum si_sm_result smi_result;
> +	int rv;
> +
>  	/*
>  	 * It's impossible for the BT status and interrupt registers to be
>  	 * all 1's, (assuming a properly functioning, self-initialized BMC)
> @@ -661,6 +623,48 @@ static int bt_detect(struct si_sm_data *bt)
>  	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF))
>  		return 1;
>  	reset_flags(bt);
> +
> +	/*
> +	 * Try getting the BT capabilities here.
> +	 */
> +	rv = bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
> +	if (rv) {
> +		dev_warn(bt->io->dev,
> +			 "Can't start capabilities transaction: %d\n", rv);
> +		goto out_no_bt_cap;
> +	}
> +
> +	smi_result = SI_SM_CALL_WITHOUT_DELAY;
> +	for (;;) {
> +		if (smi_result == SI_SM_CALL_WITH_DELAY ||
> +		    smi_result == SI_SM_CALL_WITH_TICK_DELAY) {
> +			schedule_timeout_uninterruptible(1);
> +			smi_result = bt_event(bt, jiffies_to_usecs(1));
> +		} else if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
> +			smi_result = bt_event(bt, 0);
> +		} else
> +			break;
> +	}
> +
> +	rv = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
> +	bt_init_data(bt, bt->io);
> +	if (rv < 8) {
> +		dev_warn(bt->io->dev, "bt cap response too short: %d\n", rv);
> +		goto out_no_bt_cap;
> +	}
> +
> +	if (BT_CAP[2]) {
> +		dev_warn(bt->io->dev, "Error fetching bt cap: %x\n",
> BT_CAP[2]);
> +out_no_bt_cap:
> +		dev_warn(bt->io->dev, "using default values\n");
> +	} else {
> +		bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
> +		bt->BT_CAP_retries = BT_CAP[7];
> +	}
> +
> +	dev_info(bt->io->dev, "req2rsp=%ld secs retries=%d\n",
> +		 bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
> +
>  	return 0;
>  }
> 
> --
> 2.7.4

