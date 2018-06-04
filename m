Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeFDTpq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:45:46 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com ([40.107.3.105]:44913
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751297AbeFDTpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:45:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v9 5/7] i2c: fsi: Add transfer implementation
To: Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528138850-18259-6-git-send-email-eajames@linux.vnet.ibm.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <92b61473-b5bb-ea2e-56ce-5375641c5242@axentia.se>
Date: Mon, 4 Jun 2018 21:45:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528138850-18259-6-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:7:29::29) To HE1PR0201MB2459.eurprd02.prod.outlook.com
 (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:Rw5C/JC38KyB1AyCTCHjVunhkmqPZtOn5bU5Xy3Omc9nLFYk8L5laaOTSXw9x1yHlXQSYzzM2X/pcAFkT2IRwR5kEi8amfC4nq7Fhw73PbiZkj9eVv6+skS6Om1wCqYA6boZHYMqyRvbqesqAFH7fVqKc5cHi+hTaxri9LJ2OLNSuGJyNUGlgib6twkvS1TjRsaObUbVfkEAj6G9kGYjtuFeBtEVhBLWIcRwBPqIlkhHpXCsjw4zHVNlnXpSckey;25:kmHmjIRJRtbVKp0nf0SkWVCTCRj4QTGyv69k3SQj2axd5TYgJtse7i5neI4S823fSlCMlTRbmcEIX+pCYFMnYhmAsA0deG76cJJTWT+nG6mewLcGv/iHGTdKPYJAjwgK87wk2VTdn/MP7yq000ypmGdzDpsHyvCtiKspNg4mxDACl+vAvj65cy9RslIR02N5PmlzXR3rw2BudYU5HWOQZDV+HNG9b0F+g2PjeYq/kvy1Awsa00MZydAqSBAeOY5AOfsdr8K4egRzZMOQVGSiewyotMp2TkH0lpH9cztXnTLCFpiHX13Ku/RnFzGY6NZlWG+no9I5vtI6XUWjNlssqA==;31:1iUx2chW07r+J7bttUXrw3XxQtW/TdQod1Q/YhZ2UxadSQ2QxrhO6QPmc1IUy+ysQ8SLfCXFHLzTRu4Z3dnmQ7OG5J9R2NPfhMCaF6d31oUu0Bpnel59wEb0RLowkt1bPujrReP+8Om8yohvZk9zrK7j6PuLaBI20yp5kWBaG6KYGk+86sawF6UAcS9CrtxWpvojB7yYvEsMrVHbv1tMNA6aORIMEMKNep9Ih2ijEZM=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245927B0DD6CC3CFD3A85356BC670@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:ruj2XlhIZkwLGslFCimsAqAMxHudwQ7FUjpoajZ/d7bfJssjmhF9SA26HMi55/N5nKTt50uuHLfp2lO75c/CABosKx/UrzZH0kaZRk8xLxG3Eos1hPmT1oZDRj7Yj+uGK8ZCLKA1jz1rH/qnus4BpQsYA0YzyXTezU3PB6FvY88faa0tNPC1uCiJnQqfAP6OaXmd6wmATmj+VqKKg9svL8O92RSvqTvaN/EbKnVh3ZzDCcUjyGZ8Tznqo+/gX5W3G8MdFKsFxc6nUWWC+hKBqmVdabZf1bIP0LenSVHHacLyblL1RYqSUUIqV8urbzQn
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39380400002)(39830400003)(366004)(396003)(346002)(376002)(189003)(199004)(77096007)(16526019)(6246003)(2486003)(230700001)(81156014)(59450400001)(52146003)(23676004)(8676002)(81166006)(36916002)(65806001)(486006)(305945005)(117156002)(50466002)(5890100001)(74482002)(229853002)(66066001)(52116002)(105586002)(76176011)(106356001)(65956001)(97736004)(7736002)(31686004)(6666003)(6486002)(2906002)(64126003)(16576012)(316002)(478600001)(53936002)(956004)(58126008)(4326008)(47776003)(3846002)(2616005)(7416002)(68736007)(11346002)(8936002)(476003)(6116002)(3260700006)(25786009)(36756003)(5660300001)(65826007)(53546011)(386003)(39060400002)(186003)(446003)(26005)(86362001)(31696002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTk7MjM6RTNLNlh1NTd0NVhBUDJjSGczOXpsZFI2?=
 =?utf-8?B?L1N1RUJmNXM1cWc2T1dHS0JCU0twOU1BWmFJL3FXRmJhYUdjR0ZUVml0R3JU?=
 =?utf-8?B?RjFYMFpYam9KME9iMUNUbk81V1BNVWVpbm5KcEUzS0M1Skhna21ITGdQeW92?=
 =?utf-8?B?elh5RFhsYzlLVVN2aHdoNkRCc25xRE05WFBlaVgrV2JhU1VXWmNOQTFibVdx?=
 =?utf-8?B?dUtIT21WZnBUSHgrS29tSm9RVmo0LzJxWGp0L25nbHNMSUdSRmFIQ0dqZ0Fh?=
 =?utf-8?B?V2VKblAxOUgvRjVpVkFBcU1tUmZDZlVzN29BZEpzNEpCTHpCNERxWVNEeXlm?=
 =?utf-8?B?OWgwYWpmclpIcTRZbDJDUWJ3Mkh1MG1iL2hDalcyamt2ajB4SHBoeVdnV2dI?=
 =?utf-8?B?ZVBIdUw3akdzQ2RiUkdmRnpsOWR2SzkxTHRPUG9aMFYwaGhlRUN3OFk5TUxC?=
 =?utf-8?B?ZHhHZVVLdXFrSHZ1MnEwTFlDQUljcWEvV2xKT1RjZ3RvV1M5bTF0Mitxakl5?=
 =?utf-8?B?S3AxdDZZSCtXQXBRbms3cXpBRkFseWs4U1NEYjJ6bkg1K3JVazhCaG5kbVdz?=
 =?utf-8?B?Qy9EWG5oaGZLcjRsOSt2djFwelhVQVJ4NTdDRVVhdGNQaFBQdHg3Z0hiY0Ux?=
 =?utf-8?B?SnllZzU0VVgvRXpTOVJOaHZwalVSRWtUSnV3cU1IbldqMjhzdHFwTjIwa2FF?=
 =?utf-8?B?ZHlIVlVaYUtrVU9YVUVtQ1dsRDJwQUtzcS8yVzg3L0RKeCtXZjVkK0FKZm95?=
 =?utf-8?B?a3ZtaWpHRElwS0h2dXBnUVUyNWprd3FOUE5IMTYxUVo1bnNFQWtYUEsrSjhq?=
 =?utf-8?B?WHNMd2tqdjFPd2EvbXIzOXl1ZXJjTnd4SGtwMy92elI3Q3ZuT0tkc2RIT21P?=
 =?utf-8?B?bnFSSm1vZThRYUZmNEFZMEU0QUdCUjA2VjNmbUZ5d05aS3lJMGduNXM2b2I1?=
 =?utf-8?B?YkZhaHdGUnJpMzVsNmxneldicEhPZUNMV0tsMXpGU2pMTmh1aXRHV0VGWU5k?=
 =?utf-8?B?L29XNFBFT3NIOWx5Y3oxNU9SSU1Xdkk1Q0d2UkdRSWtYbzBZR2JvdVpkR3R4?=
 =?utf-8?B?Um43YjN1QnIrcWFqUU9YcEQ0ZVNFbHo2U0UvUGdVUzh5ZzF6V2gyR010bjdV?=
 =?utf-8?B?WlROK09QREdJN2xCYkR1Yzd3QkN3d01zL3VFdEwzNlpXcFRCWFlmak9tNmhl?=
 =?utf-8?B?SkxPQ09jWXVqcXZTVldwR2JWZ2FyQkI1ekpVaysrZnlqck9neHp5TUNmTzA3?=
 =?utf-8?B?TU45eDk3M0xCcG40Y2JVVEFpTlRkNndoVXhDK3VYNUEvTmFvSzNEdTZZQjhv?=
 =?utf-8?B?cDlEdmFYOTc2dGFZUysyUkNWTFBEOXo1cUtJZHUvQTd2dHJnUEh1cHJhNUZ5?=
 =?utf-8?B?Q1V2Lzk0T0JCdXlOWXA2emZHQWtPL1UxYkQ0d0RYR1NURC9PNHB5ZiszdGU1?=
 =?utf-8?B?OFBEaHZsODFTNGZTZXhKNkZzY2R6SW45ZjZxQm1mdEt1NEJCZW84dTcvQ1I5?=
 =?utf-8?B?UExFQUYxUEpZNjlTVWJrRlA2ZG9ib3NTYVNOcGo1c213aXAxdmxDejN1K1dS?=
 =?utf-8?B?ajFBcndRc0dpYzhSWkliangvdGpXWW1KY3ppTHczWlVKWEZJUzMvcFAyVW55?=
 =?utf-8?B?SFJwQi9BTlJ2S3dHRDBZWHVHS3BocGRWU1UzbUtzZUdNN2thOUhLMzNRQUNN?=
 =?utf-8?B?bVFwUHBHNC8rcHVCYWE3aEcvVXkrUmZkMVB2djh1T1pNaXd1NFozNEl0aTBK?=
 =?utf-8?B?YWpQdlREOFpRQkc1RlJZK3d4Z0VuN0doZW5TMDgzbS9lMVNDUy96NDFJUVdC?=
 =?utf-8?B?RmlZQXVvazNIV3NBcnVEaEx6WU9YcnJsY0dpQ1FmWjZUWHRpaUNZVVZRMUpU?=
 =?utf-8?B?bitBZTdjcFNGMDd2REpZdmN3TlNHbEtJTTRON2kwcTdpNldWYXlJdDMvY3lz?=
 =?utf-8?B?NVZRdjJqTEFoSmk3b3pGYzhrTUdJeVJldXczbVlLeXYrNlozQTZEOGRQZGxP?=
 =?utf-8?B?MTN5NXZnbmxOSDcwRjVYOXZnMnRCRVlzenF2YXdNd21FcWhTOFJaaHE5Nm9W?=
 =?utf-8?B?TElIcHJFSDdXWmttMy84aDduZVIwV09YKzdJbVJuakMxYnNqeSt6N0ovRXlo?=
 =?utf-8?B?UkFLWk5pV3k0bW5aVzlpcWJXZzdDekh1azBvVysxcVpyRUk2c2VZMkZ3Q28x?=
 =?utf-8?B?a29VcU1MMjc1TjNiMDBUREJKNG5Na0FQbkJHUkhQVUs5N3gzWGV6WU90aDlB?=
 =?utf-8?B?Wk5tT0p4MzcwMnl2N1RYd3Q2SVA4YlBzTmN0a3owMjQ4M3J6b01WdVNFUDZQ?=
 =?utf-8?Q?YR6bTqNKCfruwRYgQg=3D?=
X-Microsoft-Antispam-Message-Info: BZL7Hh3oDPmLSHYGo78hnojjETpfnwOqOeP2vRAUUiT9lslJnK/n7UFO1/g+uAkhxOEZ61asKozEDjubTcfghv9shPVC/gsQ/UFHuc2nURAttiPWEvBk2QFglsLVhfgVUW+McPC3cbbDIkRIktvXWVfbUZxPeGtGo+KVxfR50tFPuBc2pIxPYO08jek+bbKt
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:p1FjAs7u/eEQgnOkmbkq6LNaKSzRUIlRjZOjlVZ4OBc6yRaGlAhYrWpLkWtE8CrOIbKrGtTCFhQlJZ35WilG6Wee+9Ib19tSXO645/WASYngCe11KclIZczLoQEqKfqJjUbC1v6sl3o7CjrwSNM/cWwqRPFdoKChYh44khiY8on3bQi8QBiwr+kExI1Rv5zBpCJDN8HGPEFoMDYROSlqWo4Xf3+mWysn6CTXehRCgbbS7yBndi2qsZbDx+BT0yJK/jZ3sGWVkh/4j9rxX8wr0CW+E/7yeBK4kcd8FTWKwipDsOIfC4krrEKmpCZy/dhPqw2Sx7VKe4zFqXUESc+4jp0ouM72dexuXSChQIJoayujT/900Am/wcNccpvl98elwLOAl5wgJpfvY8BriErkTE/xiPocUM/lZKTA/0rtaCEIcj6G8hetJ2jZLxai05eapLpxKD+0PwPYxgqnzI4zeA==;5:eAwZgv9gJtLJdO0F0HNIP4/fTdEEYZkMzc0ndQzXhkl/6XwXuhI9UzU8ESGeJBUSaVGmhW7iq2aNclbRiGBG2q1lZzpowp6zYqODvW6d8zct3zbBbPtFnepMSndwnTz8wD4gqvZz8FzkND0azvHWnTI16CJ3yU1VSd6IIfB/Vjs=;24:pW9uw82mc7AKw6p+JA/qkUkz30DM5rYCE/CoFTP1XG0KcNy02dY4d0pzyeOT/u/IfVY4UkARAo2FWo8C5xVf+Py8Y2D0xW01T5f+o1ZGaxA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;7:B9ljvUiLHm06yd16op19B2YH/Sz0WtSm2ictMrfiaXeyedCO5/SznNFjf2wSsg0vo3FgSWCj2cyXJ0mbQcDbyzGklbykLrdCeSFFOitB6z4fRsxhlte+CZyfd3mL3jQ7FldkVNGozTy5/I/U8GmxzKuz2ueCeVBBtht5vfuO0Vc7sk6NglYNwjBfrOzaLVadNnS1EmrwwsUVc2VV13Q7mOuTFGg7Nkhid67xl4M15TamP1O8sMSqnT8bwfCJvb72
X-MS-Office365-Filtering-Correlation-Id: 92535d33-d707-41f8-b580-08d5ca53bf2a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 19:45:37.7699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92535d33-d707-41f8-b580-08d5ca53bf2a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-04 21:00, Eddie James wrote:
> Execute I2C transfers from the FSI-attached I2C master. Use polling
> instead of interrupts as we have no hardware IRQ over FSI.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index 101b9c5..4e5964e 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -150,6 +150,7 @@ struct fsi_i2c_port {
>  	struct i2c_adapter	adapter;
>  	struct fsi_i2c_master	*master;
>  	u16			port;
> +	u16			xfrd;
>  };
>  
>  static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
> @@ -225,6 +226,99 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>  	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>  }
>  
> +static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +			 bool stop)
> +{
> +	struct fsi_i2c_master *i2c = port->master;
> +	u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
> +
> +	port->xfrd = 0;
> +
> +	if (msg->flags & I2C_M_RD)
> +		cmd |= I2C_CMD_READ;
> +
> +	if (stop || msg->flags & I2C_M_STOP)
> +		cmd |= I2C_CMD_WITH_STOP;
> +
> +	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
> +	cmd |= FIELD_PREP(I2C_CMD_LEN, msg->len);
> +
> +	return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, &cmd);
> +}
> +
> +static int fsi_i2c_get_op_bytes(int op_bytes)
> +{
> +	/* fsi is limited to max 4 byte aligned ops */
> +	if (op_bytes > 4)
> +		return 4;
> +	else if (op_bytes == 3)
> +		return 2;
> +	return op_bytes;
> +}
> +
> +static int fsi_i2c_write_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +			      u8 fifo_count)
> +{
> +	int write;
> +	int rc;
> +	struct fsi_i2c_master *i2c = port->master;
> +	int bytes_to_write = i2c->fifo_size - fifo_count;
> +	int bytes_remaining = msg->len - port->xfrd;
> +
> +	bytes_to_write = min(bytes_to_write, bytes_remaining);
> +
> +	while (bytes_to_write) {
> +		write = fsi_i2c_get_op_bytes(bytes_to_write);
> +
> +		rc = fsi_device_write(i2c->fsi, I2C_FSI_FIFO,
> +				      &msg->buf[port->xfrd], write);
> +		if (rc)
> +			return rc;
> +
> +		port->xfrd += write;
> +		bytes_to_write -= write;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsi_i2c_read_fifo(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +			     u8 fifo_count)
> +{
> +	int read;
> +	int rc;
> +	struct fsi_i2c_master *i2c = port->master;
> +	int bytes_to_read;
> +	int xfr_remaining = msg->len - port->xfrd;
> +	u32 dummy;
> +
> +	bytes_to_read = min_t(int, fifo_count, xfr_remaining);
> +
> +	while (bytes_to_read) {
> +		read = fsi_i2c_get_op_bytes(bytes_to_read);
> +
> +		if (xfr_remaining) {
> +			rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO,
> +					     &msg->buf[port->xfrd], read);
> +			if (rc)
> +				return rc;
> +
> +			port->xfrd += read;
> +			xfr_remaining -= read;
> +		} else {
> +			/* no more buffer but data in fifo, need to clear it */
> +			rc = fsi_device_read(i2c->fsi, I2C_FSI_FIFO, &dummy,
> +					     read);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		bytes_to_read -= read;
> +	}
> +
> +	return 0;
> +}
> +
>  static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c)
>  {
>  	int i, rc;
> @@ -388,17 +482,114 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
>  	return -ETIMEDOUT;
>  }
>  
> +static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
> +				 struct i2c_msg *msg, u32 status)
> +{
> +	int rc;
> +	u8 fifo_count;
> +
> +	if (status & I2C_STAT_ERR) {
> +		rc = fsi_i2c_abort(port, status);
> +		if (rc)
> +			return rc;
> +
> +		if (status & I2C_STAT_INV_CMD)
> +			return -EINVAL;
> +
> +		if (status & (I2C_STAT_PARITY | I2C_STAT_BE_OVERRUN |
> +		    I2C_STAT_BE_ACCESS))
> +			return -EPROTO;
> +
> +		if (status & I2C_STAT_NACK)
> +			return -ENXIO;
> +
> +		if (status & I2C_STAT_LOST_ARB)
> +			return -EAGAIN;
> +
> +		if (status & I2C_STAT_STOP_ERR)
> +			return -EBADMSG;
> +
> +		return -EIO;
> +	}
> +
> +	if (status & I2C_STAT_DAT_REQ) {
> +		fifo_count = FIELD_GET(I2C_STAT_FIFO_COUNT, status);
> +
> +		if (msg->flags & I2C_M_RD)
> +			return fsi_i2c_read_fifo(port, msg, fifo_count);
> +
> +		return fsi_i2c_write_fifo(port, msg, fifo_count);
> +	}
> +
> +	if (status & I2C_STAT_CMD_COMP) {
> +		if (port->xfrd < msg->len)
> +			return -ENODATA;
> +
> +		return msg->len;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsi_i2c_wait(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +			unsigned long timeout)
> +{
> +	u32 status = 0;
> +	int rc;
> +	unsigned long start = jiffies;
> +
> +	do {
> +		rc = fsi_i2c_read_reg(port->master->fsi, I2C_FSI_STAT,
> +				      &status);
> +		if (rc)
> +			return rc;
> +
> +		if (status & I2C_STAT_ANY_RESP) {
> +			rc = fsi_i2c_handle_status(port, msg, status);
> +			if (rc < 0)
> +				return rc;
> +
> +			/* cmd complete and all data xfrd */
> +			if (rc == msg->len)
> +				return 0;
> +
> +			/* need to xfr more data, but maybe don't need wait */
> +			continue;
> +		}
> +
> +		usleep_range(I2C_CMD_SLEEP_MIN_US, I2C_CMD_SLEEP_MAX_US);
> +	} while (time_after(start + timeout, jiffies));
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int fsi_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  			int num)
>  {
> -	int rc;
> +	int i, rc;
> +	unsigned long start_time;
>  	struct fsi_i2c_port *port = adap->algo_data;
> +	struct i2c_msg *msg;
>  
>  	rc = fsi_i2c_set_port(port);
>  	if (rc)
>  		return rc;
>  
> -	return -EOPNOTSUPP;
> +	for (i = 0; i < num; i++) {
> +		msg = msgs + i;
> +		start_time = jiffies;
> +
> +		rc = fsi_i2c_start(port, msg, i == num - 1);
> +		if (rc)
> +			return rc;
> +
> +		rc = fsi_i2c_wait(port, msg,
> +				  adap->timeout - (jiffies - start_time));
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;

Zero is not the return value of success for .master_xfer

Hint, "num" is your friend...

Cheers,
Peter

>  }
>  
>  static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
> 
