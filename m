Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967424AbeCSQrT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:47:19 -0400
Received: from mail-eopbgr20107.outbound.protection.outlook.com ([40.107.2.107]:45367
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964999AbeCSQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:47:12 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
Date: Mon, 19 Mar 2018 17:47:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0902CA0031.eurprd09.prod.outlook.com
 (2603:10a6:6:2::44) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8cd3c0f-e32e-458f-6ce3-08d58db90e13
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:SB5+0e1bv1RAK/Det7QHDugfnsMP7CEVmaKhIQd787lcUk4hrcTVYNbgVv3PG9X9k4UMpzfFLid3SPu2vVAGphgaQgk0W4fTae4dG91+oBSRB5lBJyYjGarhAosqJOv+gK1lrNRwEgMatcBXFhBiA/eHFy2oI6gXpG6vmGavSX6RJXLf/u600Xr0ePz82YXST9EtZdU4SrQj9J6AZpeCzHRc8gN+A/KM/D/HeMm+z1wvZn8ivk+vZdiwPoYlUCy8;25:V3polSaIeBQgZoSgzEiCv8mdUzb83oA04fF20Bugg2Cg4qIGenrDQfnqM7ISuArnQRoMW6Ea/dkqyYk190eCz0OR6eStMJBm4zYd3iDUOq1lEXev/mkFa4pXDb5RrEUN2HuXCiuvcLnoGriSTeaRovWXCP+yiR9g4yIYhdnGQRP/GYRFojk+hhu3MdjdXz+S6gUaqbgHS1ZPUVnNZ3+Z2WjcxW+tMmmIqnKGyHqOq4ivdIyD81ESc5fNHL5BuNVNQDIu+trO78Y10IneEMuDmR0paQH5d4Lxgsv554qUq14jroxYeE6ydqkeMZkpYna720VZteRWqSZFUSrroP/X9w==;31:IrXLTm6hP0dClqxRgql6114StYL4AFL4249rmllLXpe5g3h5dkfseVBmXrUgr3dWrZD2mlwX1yuJiq5G7S5Y48dZVfJ9QYeJ01IwxaWA22OwwdE2HACDrgHMjWq7GKFeyWlWtU5qwOOOgwAuMNOf2HDQqPj7TQ0tq41nY8IAOFAc6Bnsjin9j51LV7zqmHCUcXcrwhjIfWoLxA5cqZP+21cjkGnoJk6hk8G0aNVKveY=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276936D8C0896D5AD0B0D6FFBCD40@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:DFaYH1xCyxlAtYLufkx0wbGvJ8jPNDn19EUA1IDVGT+PwOdMBW7tJ8ZpX2TN5AM37YY22RkfbolETu+fmw0vvylQmrl6DR9bYDSZ48Jvd30R8URF7zjF3uh7qiPZYDNfCgob/JLXzH2z9IzPXnXb9K4MJUivGXpD0BrGbKMMV6hwoGUXOgzzKNsdRtsjBohGLWgNsWO8jmwk3DQ3H4s1GIU1+tu7EayKZlX9709QJrRJrUQyOsIOBcID+rOn+n5fe7dRgngapFDvKPX55x+x4w==
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(39830400003)(396003)(376002)(366004)(377424004)(189003)(199004)(52314003)(2906002)(4326008)(58126008)(230700001)(26005)(117156002)(74482002)(386003)(53546011)(97736004)(6116002)(6916009)(54906003)(2950100002)(6666003)(3260700006)(186003)(15760500003)(65826007)(16526019)(25786009)(106356001)(316002)(77096007)(5660300001)(229853002)(86362001)(16576012)(8676002)(47776003)(81166006)(64126003)(81156014)(59450400001)(23676004)(66066001)(36916002)(65806001)(53936002)(6486002)(15650500001)(8936002)(76176011)(68736007)(36756003)(50466002)(105586002)(305945005)(6246003)(31686004)(31696002)(3846002)(478600001)(7736002)(52116002)(52146003)(2486003)(65956001)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3Njk7MjM6RWY3UUE5SjlRTmgxMFpkMTNFRnlBR2p4?=
 =?utf-8?B?b3VJSTZ2QnRKbytldDNhWHliYThlTFA2VktVVUJuL05PMzZZVEkrUzQ5cUgx?=
 =?utf-8?B?cDFhd2luVmphUVBUVSszMC9lZHprYVdCWDh6TTFlNlA4Vkw3cTV3TE5CMytI?=
 =?utf-8?B?cFRYZlRSZmp6ekpDOENWZ3JLNWMwQ2JMNkdVZWo5N3BkWk5LMjVYNzRkS2p1?=
 =?utf-8?B?Qm5aZDB5djJrUnhwRmk4Y1Yzd3pKV3RlR1NhbkZxdFlwSXpIN3VLS2ZzK2Y0?=
 =?utf-8?B?d1U4Qzg5S1VGemNab3B2VzJ6TmZMOUFDYmFQbzI0STIwYmYxUW9iQ25VQU55?=
 =?utf-8?B?ZEd1cDlpS1p5V045ZkxmazIycFZKS2dwVjViTmlmVXh1S2J0TnRhQ25CWmpN?=
 =?utf-8?B?SEV5UlBPcmx3UmEyZWY3Tk1FR1AxcVlIYS85WllqS1ZwUnNKMzlNSHgzeFl6?=
 =?utf-8?B?OXpFNHNiSklDOTdERmFuZnNoTWxtNW40Rk5pa1FpUmp0bit3QTlpM2R2T0dm?=
 =?utf-8?B?dmYzQUVvUXZJZWJObTZQMlVFTy9iWHdRdUMrV2pveXFBeUhCY21DN0gzQ1FK?=
 =?utf-8?B?Z1J0L1h4Q20rSFh4V3hmbmxaQkprTEdzZHdoUzZtQWJNbFNmMTFVYVdXeUlz?=
 =?utf-8?B?U0ZMeUZqWnU5MGpwcEdocnh2NkRzRXo2NzJPN29qeDBSaVhVTFV3Y1NGQ2c5?=
 =?utf-8?B?NlI0MHkwdG5vQzF4VFRsNnF4UVpaK21LZHlQa1R1cmVuODVHYSt4SFRnTHlS?=
 =?utf-8?B?YzBVa01NVUVFZDF5cE5FdWNrMElGZHk5SEp0UFZpaEV4NWtEQW9iTm9mZVBq?=
 =?utf-8?B?dXFmM1RlazhWdUhpS0RVUXRjSjhOYjJoL3V4ZDZiWXgyMWRrSFB0ZHkzbnNV?=
 =?utf-8?B?N1hIY0ZxTFZPTGoxT0xuSFM0ZlpxTTFlOVBEQzhoelMvQ2ppVVBvZjNMOTlV?=
 =?utf-8?B?MCttMzRFT2FHQUlFR0RMeXErM1ErRzNRZlhENWpjczdLcy9pVEYydkFMUHlW?=
 =?utf-8?B?aEM2SVlFRVBYMStoNHc0WmRpUTNmbWhEWjV5NEZLQ1dsczlaNjdLc2VtZzlh?=
 =?utf-8?B?RXR5SGtLL2FpNHdERWpwNjJmR1V0TGdhbEFBbjZqNFgramo5czJuaURqRUxT?=
 =?utf-8?B?NmdvWlhyaGVQczVITXlLWDdzRTNla3ZINTd3R3BQd0xLU1lFQmpUY3NSZm9S?=
 =?utf-8?B?cmpOOExNdGM4T0k4ZWRFSVJ5R0VScHBWWE1NZFNaZEFsRm9DdjJPYXJVZjdo?=
 =?utf-8?B?dkRDTUVxaExQSlZlTno0TzgrN0lic0l4ZlExeGt4eGEzQXh3cFBGV3BORTZt?=
 =?utf-8?B?ZGd5dnZMVlA0Q2hUVjFsZkhTOExEaXVQM2JSL2VXWjNKdnhnWmdzMG5qQ2Ix?=
 =?utf-8?B?c1BzMHJKSVVkanpOeFYxY2pNS0VvS0xoVkZQdGR4ZzdwcmtrS2RHaHAwRGQy?=
 =?utf-8?B?aFpjNE85ZU1kK1FLdUdFTklidm5icmo5M0RkSnZiek5SSDVhNExtK2VHNWxT?=
 =?utf-8?B?U1FnQ3dVUkp0MG1nOGRHbmRZNEQzbkV2bndiSjR0VmcraWYwbkoyTGU4SzZx?=
 =?utf-8?B?TjVUN0x1SVFMbXljZWR5R0IrWXF6QnE5eFdoWUkrT3k2MXBzTDN3OG5QL1g1?=
 =?utf-8?B?bkxWYTdpRGlrMTYwL0puUjNscUx6NkliZjFSek9TN2NGdmkzaWVwZnIxNnM2?=
 =?utf-8?B?ZmRGVzY1YUJvWHlIQlZrRnJNc1NaNlhYQ0RjMG0vV2ZnZmEwOHRQUExvdW5O?=
 =?utf-8?B?RjJZZDZNTHVkN0NtWm4xaFFRcEh0eHQwVVl4R1hvaVhjOWU1aVh0MWdOY1Jx?=
 =?utf-8?B?d1FIWEtUcFVTOUJwZFAzQUl2RDBtQ0hpbXFUTUpGZ0R3N1d3RURNTTVvdVRN?=
 =?utf-8?B?M24randJakwydnQzRG82dXBqaFlyYU9CSXhncHo3c1R5L1ZPdk9tanF3VXE3?=
 =?utf-8?B?UkxKczRIOTAzcXg4QnlqZ1NUd2NZeE15WlZjNTlURFo0dUN3bHpsS1UyVDk1?=
 =?utf-8?B?WmxmNGhWenhwd1lFTjJUSzBCS3Bsc1IyT1NMa1RVam9GWnZSbGE1ZTV3Ym5V?=
 =?utf-8?B?MlROd3BwbFBhSnZZT1FqZlFnRjJhOW1qUWdBdklSRS9BQ3l3NmpVSE9wVlR2?=
 =?utf-8?B?UnBQdzVQbVJmc0t3SWRyYitSaldQcUFqdDNlalBmcWRocDB3V0VKUFlpM0NZ?=
 =?utf-8?B?amFWaGxLMytOenhZTTFJT1ByZm5CekE9PQ==?=
X-Microsoft-Antispam-Message-Info: Hyio3r+YpqR6PpNGiNRxRInhV847zrmJ+S4ONZriMwuYpMyqu63IYOkA0asg+m4UkEJVjIS1HY4c8uJRIY64WTsY3x23XKYUfSx/Av7wBH8fvA1KufQ2rjM171tq6g/T3ELZf5CKp+P8jExd55rS992i3wCf8yyFPOs/bdoU4NRmV/O/sX3sUCuxcycqB9/H
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:eMozP6jXtsP+g5xrDXCJgF+oh7CvVpZXTUvchLgskT17C82rghsYZLiVx9n6TvAPOp85+WlKAoE0RO6iD1klP82RgV1deqyfEna14BUMHJdZ6uw6gsW0csmsrxNwb15F5QFC7IluKwOR1wpv00VScY4P/bWXD1el/uMzO0ORUuM+vBY8UW0cIWCglYEzBjvVBss98vd3JaMwwwy/nczVe4TI+Wg9dnrXPqFdKqJdR4CfaGn/Vc1+2w88/h2fu31vy2bC6Zgk21IibmRQjldp130l+ili6qEdVC+TAL/ZrIhljV0JNnFKoiFTw5+Yn71pojykq0bNkv5O1WzQUWAHURPhlOksCOw6GohIjBUZLWM=;5:qNIVi+jnZr5kWhdi4AdMzlYXWOWTmRgpaMJeE8y+bjVSl6JUWCiiEBZ1IjCBiDCEjxFGFOIF8VMl0Pd9qViYj2H3vZWEJ0RBQpqcvD9JMolhuOb5IIeB0aI5Am8PCoR8vxIklErMPcQRe4PxNCsbwbkl+1TBXsgFnZrBQ+Eaq5s=;24:DS3RCReDehXgM9lxeUwNrtH3DRWhjGb22O7SLh/QETpN0cqeCshpKPnI+ExgNMy/YfZkmBWwT7s4TtgbEi+iM3yLN5X8oqPT5Pq8fqCBAfU=;7:oIh3uIUFcDIpFIOz2LEnao/fdeo/aGSlTX7CyP4D8WrHTUbNGgloXnOBxaie92com653M5dCoawuLcug/rEyzUtO5uKPFbeIat+UwqFRRJXgmnqhdrmjk5sLaUEbklqXGmODeUm051ty7AtSKDndKjPm0+piunTnoJ0ld35+l8ezqeU6IckWJmY/pQItAxnXyZmtawKwujHzBVXDunplV2X6UVbAtRC9EBh4i1mWsa2cCKi0s/+2EM4Y4c6TiGHe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 16:47:08.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cd3c0f-e32e-458f-6ce3-08d58db90e13
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-19 17:10, Guenter Roeck wrote:
> Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
> I2C device id") added a function to return the standard I2C device ID.
> Use that function to verify the device ID of a given device.

Yeah, you're moving complexity from the driver to the core, reducing
the indentation level and generally make things look neater. In fact,
I thought about adding something like this, but didn't since I only had
the one user.

The only negative is the added line count, but I suppose more drivers
will call this function down the line so it should be a net win in the
long run. There was the PCA9641 chip earlier today e.g., but maybe we
should wait for more device id users?

I wonder when other manufacturers will get on board?

I also wonder if NXP will ever release a chip with part-id 0 and
die-revision 0? If not, an all zero struct i2c_device_identity
could be used instead of manufacturer_id 0xffff and that would
simplify the pca954x driver code a bit more. But I guess we can
never know the answer to that question. And even if we did, the
answer might change later. But it would be nice...

> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> RFC:
> - Compile tested only

Can't test either since I have no chips, but the code looks good.

Adrian have HW, but maybe he's getting tried of testing?

Hmmm, for testing purposes it would be nice if a linux slave device
implemented this. But I don't have HW that supports that either so it
wouldn't help *me* anyway...

Anyway, ack from me for both patches. But maybe I'm the one
picking them up? Wolfram?

Cheers,
Peter

> - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
>   against all parts from a given manufacturer ?
> 
>  drivers/i2c/i2c-core-base.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h         |  3 +++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 16a3b73375a6..4e4372b064f6 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -2009,6 +2009,40 @@ int i2c_get_device_id(const struct i2c_client *client,
>  }
>  EXPORT_SYMBOL_GPL(i2c_get_device_id);
>  
> +/**
> + * i2c_verify_device_id - verify device ID
> + * @client: The device to query
> + * @id: Expected device ID
> + *
> + * Returns negative errno on error, zero on success.
> + */
> +int i2c_verify_device_id(const struct i2c_client *client,
> +			 const struct i2c_device_identity *id)
> +{
> +	struct i2c_device_identity real_id;
> +	int ret;
> +
> +	if (id->manufacturer_id == I2C_DEVICE_ID_NONE)
> +		return 0;
> +
> +	ret = i2c_get_device_id(client, &real_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (id->manufacturer_id != real_id.manufacturer_id ||
> +	    id->part_id != real_id.part_id ||
> +	    (id->die_revision != I2C_DEVICE_DIE_REVISION_ANY &&
> +	     id->die_revision != real_id.die_revision)) {
> +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
> +			real_id.manufacturer_id, real_id.part_id,
> +			real_id.die_revision);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_verify_device_id);
> +
>  /* ----------------------------------------------------
>   * the i2c address scanning function
>   * Will not work for 10-bit addresses!
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 44ad14e016b5..45bae9717ecb 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -189,6 +189,8 @@ i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
>  					  u8 command, u8 length, u8 *values);
>  int i2c_get_device_id(const struct i2c_client *client,
>  		      struct i2c_device_identity *id);
> +int i2c_verify_device_id(const struct i2c_client *client,
> +			 const struct i2c_device_identity *id);
>  #endif /* I2C */
>  
>  /**
> @@ -216,6 +218,7 @@ struct i2c_device_identity {
>  #define I2C_DEVICE_ID_NONE                         0xffff
>  	u16 part_id;
>  	u8 die_revision;
> +#define I2C_DEVICE_DIE_REVISION_ANY		     0xff
>  };
>  
>  enum i2c_alert_protocol {
> 
