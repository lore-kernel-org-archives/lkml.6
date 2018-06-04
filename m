Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFDIlJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:41:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45268 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeFDIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:41:07 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="81503423"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: "gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [PATCH 5/7] scsi: ufs: Refactor descriptor read for write
Thread-Topic: [PATCH 5/7] scsi: ufs: Refactor descriptor read for write
Thread-Index: AQHT93m2cj4AQ98YsUWxkpqqUz6OCKRP0HyA
Date: Mon, 4 Jun 2018 08:40:44 +0000
Message-ID: <21ce321eb2d81d59d6e4578669b8287b9ac4d29f.camel@wdc.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
         <20180529181740.195362-6-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-6-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1217;7:Paf9OQTTIZ0MUkdttnjrVQ6GU6n3O0XIYJ0EsOMO+1jDl0q6oT1S3N/dkio/1sH+yb7JwE55wFLJXVlrqQoFjRDG95hfVHzA/nQZxw/NTPze0qgbKWdZ/VYpgyjdRkYo+f6r5FK4nMm6640iA7sRa44TkeUFAXOWk3Cetj/OWlLZpxZ2hvKtiUHW8E2gTy9hWBNi1mVILJ2gguT0B+UCtNTZJcfelRytcqS8xEvCRuxC3EMn9F94fffl+9gXpJnk;20:fFbcZ5ulMJnqKfyOlCSY5PN2F9VX4DIEQbK0Ysye8GPqpL/M3qt/ut7o7EoteCO1o5nJQQGizP4TXjLXc2rDdmL/ev9EpWEqFQ2FnrkPcf2sX9BoacwdYxYWOi7q1cfd0aLIgZRmPVR6obW1iGzNfpyux4T0dJwcPxDmLWW8Y3E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1217;
x-ms-traffictypediagnostic: MWHPR04MB1217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1217ABF6ECC6BE051E3178EB98670@MWHPR04MB1217.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1217;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1217;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(346002)(376002)(396003)(199004)(189003)(51444003)(66066001)(99286004)(6486002)(6436002)(2900100001)(229853002)(36756003)(53936002)(5660300001)(76176011)(6246003)(6116002)(86362001)(3846002)(2201001)(3280700002)(14454004)(6506007)(2616005)(476003)(6512007)(72206003)(11346002)(446003)(478600001)(4326008)(6636002)(26005)(7736002)(305945005)(186003)(118296001)(2501003)(97736004)(5250100002)(81156014)(8676002)(102836004)(81166006)(8936002)(105586002)(68736007)(106356001)(486006)(2906002)(39060400002)(3660700001)(316002)(110136005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1217;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: z/Olvhh2Y4njUBnQOMlhhE1zPjmbg7DDyIyNral0DDu1kvfxQLf9uZ7S1OS/qRbGn7ZoBBN0s7elfVXvhJS2QitrHJqv5xwljLRM0E+AzGhvzMIwoL5ScDbveOKwTvADYMpwuuhNF0jEjRPXzozgKBTyBkQDek4HVQcApvAWrctMrraaffO/nKYU8A+EE54D
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DE722D568C8E3488AD4385EC7C4D432@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 65e10ab3-8750-4aa9-1ad9-08d5c9f6dca7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e10ab3-8750-4aa9-1ad9-08d5c9f6dca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 08:40:44.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1217
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w548fFEN028745

On Tue, 2018-05-29 at 11:17 -0700, Evan Green wrote:
>  	/* Check whether we need temp memory */
>  	if (param_offset != 0 || param_size < buff_len) {
> -		desc_buf = kmalloc(buff_len, GFP_KERNEL);
> +		desc_buf = kzalloc(buff_len, GFP_KERNEL);
>  		if (!desc_buf)
>  			return -ENOMEM;
> +
> +		/* If it's a write, first read the complete descriptor, then
> +		 * copy in the parts being changed.
> +		 */

Have you verified this patch with checkpatch? The above comment does not follow
the Linux kernel coding style.

> +		if (opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
> +			if ((int)param_offset + (int)param_size > buff_len) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			ret = ufshcd_query_descriptor_retry(hba,
> +						UPIU_QUERY_OPCODE_READ_DESC,
> +						desc_id, desc_index, 0,
> +						desc_buf, &buff_len);
> +
> +			if (ret) {
> +				dev_err(hba->dev,
> +					"%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d",
> +					__func__, desc_id, desc_index,
> +					param_offset, ret);
> +
> +				goto out;
> +			}
> +
> +			memcpy(desc_buf + param_offset, param_buf, param_size);
> +		}

The above code is indented deeply. I think that means that this code would become
easier to read if a helper function would be introduced.

Additionally, I think locking is missing from the above code. How else can race
conditions between concurrent writers be prevented?

Bart.
