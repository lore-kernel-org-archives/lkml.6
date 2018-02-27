Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbeB0FA4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:00:56 -0500
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:41643
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750746AbeB0FAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:00:54 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
To: Wolfram Sang <wsa@the-dreams.de>,
        George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
 <20180226202248.ej3bt5o7sam6qljv@ninjato>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <a96c4bb2-fbc5-3e21-f6b5-4da75fac3c01@caviumnetworks.com>
Date: Tue, 27 Feb 2018 10:30:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180226202248.ej3bt5o7sam6qljv@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (10.174.220.29)
 To SN1PR07MB2334.namprd07.prod.outlook.com (10.169.127.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcac22b-2c1e-4eaf-2c07-08d57d9f1331
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR07MB2334;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2334;3:lBZ8Hs2l9VWSpU//h5x77ByVAsczAOEcO2ajlPZQKYUU2AKoUUs6ax3ovTPZ4nstPsxIfxP+9WhbqVnDtf3L24rtOQ8+Z+VBd4Y01HcBaoJJ7ecCzcivw8G2hmj62dekFvivgEQJTylbt+78mkdzCtINgiWirOIctgLlOfoBypSiDUU9gn8q66NBIYW1WdQQaqe/bVgjBZkWqKjy9mudIzlwCu1eUWr260Wv2kDkJXcgAkquMN3t0aMZtKVMPfbR;25:4Cy4Ns6pdISYKrM8bIJUPnr6AxU8KYXpfJV8yG5oSVwVB3Aelu5OMUbXV4I+REebAWg2NlVmzaoiTcfReWz2HG7/nzi36L7PWmOi+8XxgGcBzyMnRN1Ofsbw+Swq0nWlExRLE8+2FuKk3FH1BEzw8B4qxvVNnAydDGtMlNEjyqMMHI79NXKdf4WRR7XFL8eccynmxosj75qS8oNrp03Ij5aIuF3lFqCR+eSI7YPWuGPOqsftJZgmZ4YKE6/pf3t7ZfAoUnUqKu+0+tpPk4oDZQGlVGRlHb05AEHmGk/bZtXDe4AnkdVo3vy/9P86lYEmfoztRaVfrXAWbeVaL6Mf9Q==;31:yoYqZ9fbkn3/cHhbpaK9hKBowsH6hHkIJuHxL+Ju3Txhey+BYnVMC3EvvAAEFzGasFktOqnjwWknvpZSc0ZvWbkfvA2Ng9JZyKZjR+0B1edFowqGJE4dxok7O22/c3WYYAX2EMh7oqbl7wyP2lJla2XxbGOi0FZmAipWs5Umi8U5mAGrwOWFD1Havv/MyHFzst9fQRS0Ql9bYAMoK494PVG84bYFURnqD+nM559HBAk=
X-MS-TrafficTypeDiagnostic: SN1PR07MB2334:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2334;20:0mQQTrC/Zp3wIuYX8BkQ3jFvW1r1PJAPaW5vMri1QGbYy2+IoCIv2GDBO/I0EE8z/4y1lROLionejV4KE3zyarhOeDhmCR6B5g6iGQUf6UfLj/Y1M4tgWjeF1NtEVWLTKMUTbnmcKbA4Vt3PGUB0aOsLybZMd0m9AsnOelkc3v3+O91VvZUEOoEEYCqB9pgBoYNO92mzmLIk9co8eBFyqjeeOjsemUnlpZ1HhCaeOZhfIeY9Ib3qzs/wD8gGv+DJprJZeVniA6Q/K47gw+8dYT5HBULKUT2a6q/T9cVMIqf00qmV0iESQAM9//CJumGGOFtOp9vpIykFVWoIZTey0KJDoh6V489A8WUwab+7K0CtVpoYsbe3MnPrpkFtL2TmFyiolUBzhf1QYOFvfS1E1/EzWLn37Qg1TALsLb6z3Uk2ofpmWsEt/AbzxS0Nnn8H0udrFVP+wOEIEcPRZWzOk0aZZFy6qT5oAwi/I6Jzaj7UmRoZ2GyGPpZJU+hhl9EiGpBDyXp7aglFtxnxcBmMXIng9q9MBn9Boe0s0a3uci5CYtmUiuV2uN+rt1Z6eJkL4pNyWCx+ddhUS2Ttj5iBl0wlYxVcM4VC5KfOd9RVmk0=;4:KrVY+82tEHv+AXPdKU5Dm/nWxTMo3wJNHhfovNhFL6c92ifnyTCXiNByZwYGCHFw//5O3GlJBpDBJZWr9HJJd0yrB4IjZeaCC2jb6bxksRoBAfBa97rtEe/E5+QtnKx1eDkYYLBYsBi/BtsJlTVGx6MSXYYNt+zWtlZg6ud45tEzgGpyCsIAEfTCvTmLZfuLkqb0sxRVPfCopcnDKcV4JvBO7JLTxajaLOhGPZsD3T7tyA5bpn96SFpE9UP0amFfJbhJSo891gNp18x89J3j/A==
X-Microsoft-Antispam-PRVS: <SN1PR07MB2334D5495CD23984BA06B8B3F9C00@SN1PR07MB2334.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501161)(52105095)(93006095)(3002001)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR07MB2334;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2334;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(39860400002)(396003)(346002)(376002)(366004)(39380400002)(51914003)(199004)(189003)(77096007)(3846002)(6116002)(53546011)(5009440100003)(386003)(58126008)(68736007)(36756003)(67846002)(31686004)(230700001)(478600001)(31696002)(16526019)(72206003)(186003)(2906002)(305945005)(7736002)(26005)(81156014)(8936002)(551934003)(105586002)(81166006)(6666003)(64126003)(47776003)(8676002)(316002)(50466002)(5660300001)(23746002)(6246003)(16576012)(97736004)(53936002)(229853002)(90366009)(106356001)(4326008)(52116002)(2950100002)(66066001)(65806001)(65956001)(110136005)(25786009)(42882006)(65826007)(6486002)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2334;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2334;23:M81Z4OS96YoScl/AQ4Dxi86Uh7zeiao9Mp/jQ?=
 =?Windows-1252?Q?tFnnK19jQofbA0Rll80rFyLKUFj57t/NWCI852sBShCnR0e41n6oCEAE?=
 =?Windows-1252?Q?cOLb3I0kAlbjalHGEsOY4h+RQSCZgxkMR+f3OcPESa7xTO0Mgl+DVU09?=
 =?Windows-1252?Q?FtuDh38lmlIYsc4S1/1cBPfTqiJoR8BnoTtC+aKd2gq2bKX3nAhPgzvS?=
 =?Windows-1252?Q?qx1Tid+apjF9XZzC0o70oaFHHvE/npQB27ziBOCtD9290d6hy+nPZ6Dx?=
 =?Windows-1252?Q?jeDDuEwkbxbup4xktmkIs2y3wseK970u7H0u1s5lakrIVyq6ORc59tw1?=
 =?Windows-1252?Q?nO7hL5/NkBQgBYMbO4wrGJzvu9r3ePzEBXl5j6uw40Yq1pARLS4a01/O?=
 =?Windows-1252?Q?YH7HjSQZyxlEBgJpxlHxcOJSJ6W9+yUEGyxKixqoX4Odx9JSK1zf/Bj1?=
 =?Windows-1252?Q?4DNXaO01pTj0QZYzBkEfc6p/hZkzwC//XFd0leL1tCqZckbqL0cDV6UU?=
 =?Windows-1252?Q?iQ2qOfPmPmztH+A7CMcCIMQ+s4WZOzdvglmOZyvcQnzyoDEMZWrunPXa?=
 =?Windows-1252?Q?Vgy1HMAw41Um+0w/dvYSBXakLqgKRD+3bEtey3BCZDXbkm1O56Uuk2An?=
 =?Windows-1252?Q?DfLJKgmlpMePO76ftyYtFI/zI11RWRHoEE4fKp2qfOPXJkhzoGlOtaRy?=
 =?Windows-1252?Q?slrNKpk1/zXlchbpR5jdLljLAZjaQYFX2AszEduozv2rnrg3uamUeYxJ?=
 =?Windows-1252?Q?8d1A5YM9cSK3zNqm/eFaWfgx5MpxLYsnCnv60U6d3PRuv0q039VBs4xB?=
 =?Windows-1252?Q?/YuZnz9vGRXK4BYnfeuaDzn5G62X2OYnSlkvctl/2ahxwiWPGbtDyyDh?=
 =?Windows-1252?Q?rq9GAVRD94r/louON3qyM8Zf/mpQaOfvO0camiaxFWdM0Rl9kDfpF1qK?=
 =?Windows-1252?Q?1XbtAOF/K+DEJKC8XhIFRhWYrq9UPluvgn1mmIY1EXeLkwaKBAbMH6xH?=
 =?Windows-1252?Q?eIK5fYzC0Fs6clGcQrFWUp5aswY7l+GGhcjcB54C3qDWIDIK73Wqcn1V?=
 =?Windows-1252?Q?vFLV12x8/BIT1OFYBceUptfXjuAeqMwISy5/qMs8k5R7TFvEJzhaZfx/?=
 =?Windows-1252?Q?TaQSKYfYfGbvs3KqdvCWCklLHRw7GHoA5rGlSiwIe4NBDnVKRUtMNNAu?=
 =?Windows-1252?Q?aKoShycUyUyqkQi/mGCVCWK/N7RawfWCA5K43FQzbnQJq3mkarwNdu9h?=
 =?Windows-1252?Q?uGpvuUfmuGbT9uyHTAqOP6pie9ngobEQUAgxvon4A6oBc7O/smJqzrib?=
 =?Windows-1252?Q?wgKopuCiX2FVCH0K/8TGE7U5RwtYO3ooPdZrZPhu4mDzGmfyRfQ4XV1S?=
 =?Windows-1252?Q?aqROnyzpOJg/MWIl3nZVXxs8y13RtxgN8y4ui2If0Yx5FDlzH2LvdkOe?=
 =?Windows-1252?Q?/hXo7LFozyaUF44bRnFxCKFpdOQ3c8gJ/bdo7XrAnF82t1KPwlcglUDt?=
 =?Windows-1252?Q?fw0wyw2gvlKUA7Ru0zkEz8Y2FKW/WA6OVZhyj6kKfpgo/1u/avJQkcJS?=
 =?Windows-1252?Q?q9eZcVPxlKLt0NaEQLi7nK/Jlo7SlHIxkh5kE0yKKqfrSwjovg49dDOL?=
 =?Windows-1252?Q?s5piAS3GhPKp7nJRcujlU7d9Ql+qTZ+lJkog5LjKnyv?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2334;6:EcpEI5Bl8LHukRf5Y0K8qsYrcspbwpJlB6hOjHCFrzseVSQLxCwzMVcCbNNe/WeDPlDqHk6kuu3RwTC/N7p4BZ4389Wpk6HlDgu+aV9+OdMlRXeZ5uweQfquyyv4zDWNoeIwKwycDVNdWId2TOtTk8v6FLKLk5yMsY3ud46GDLukK8TZwMr8cez1Id/pNtiSK1/TL5EP9c87EOqrVXodb2jFuhL/ww/U6xjVbXjLNOOt+AzF2gcQvVjURnxIcLqJVxQ0K3NcgnuEffzdML0QaCXL9+fz0OzgJ7YK9pCMhf4dhR/khaJxko2pWEexmMGZKWNnxIJDXOuWCUOyxT45a8LVEHCPQKSo+pBuVW7VxMA=;5:4NGUpqKcSjRRQ7LykiR8W7qOI8iORx9P7+AquJpJiUsNhePVRuq0OuGJLI1qbNL2ssCje6/9SNz+uOHxkrHvAwano2VOeq9QjpHS6Wy0k+AGfzid+GnFO8R+qq4Obcy5m16QaJkZFVBJQdPaXK/IzrlvddgPQs7u8nZuApBpPRA=;24:Q29GE8vWrQXxzZbYljENZMkjZxife1DtqTYXRuZchiZt+pbPh2h9L8PkTxX8hzpGsbn5GmBfCbEBw3uXIvUCWIjX8IUNbjrHm8Eo3DPDw8k=;7:QLlxrBaPHFa+KRNDV2TzZj6zNbb1Un3FgmLTR65xrzsEX5nuadi6mqjC8OFtti12vV/PSqo1KQ2OtT2nnRUYg6W7fX3oT6lvmQZEc5jrkFGssgq0GSUS1O7uVooubHzwzmV0/XqWOK23iKyM+BdEt7k9UP0mhLHbn5MEQZaCZ13y4Ek+WV9CZuGTtll5jr2UyeCWCTEO8RL4+DyAgRkPtS9LgcmlLVuuIcv0SvCnhGRYc5xxQpM9J1j/gLBfonIV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 05:00:50.0085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcac22b-2c1e-4eaf-2c07-08d57d9f1331
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for the review.

On 02/27/2018 01:52 AM, Wolfram Sang wrote:
> 
> On Thu, Jan 18, 2018 at 05:39:24AM +0000, George Cherian wrote:
>> I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
>> Essentially the driver should be checking the bus state before sending
>> the next transaction.
> 
> Yes.
> 
>> In case the next transaction is initiated while the
>> bus is busy, the prior transactions stop condition is not achieved.
> 
> I didn't fully get why you can't check the BUSY bit and wait a little
> just before you push out the next message?
Yes, I am checking for the BUSY bit and looping.
Here for reference

+	while (last_msg && busy_timeout) {
+		status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_STATUS);
+		if ((status & XLP9XX_I2C_STATUS_BUSY) == 0)
+			break;
+
+		busy_timeout--;
+		udelay(1);
+	}
+
+	if (!busy_timeout) {
+		dev_dbg(priv->dev, "i2c bus busy for too long after transfer\n");
+		return -EIO;
+	}

Did you mean to eliminate the udelay and use msleep?
In any case I will re-post another version of the patch, since
I have found some more issues and need to be fixed.

> 
>> Add the check to make sure the bus is not busy before next transaction.
>>

Regards,
-George
