Return-Path: <prvs=66055eecd2=ast@fb.com>
X-Google-Smtp-Source: AG47ELsFpo7rQHM1p7R3kb0itg+ta4FwGlr4RLFMr00jWlyO9MHEBn1Q1USjknvKkrVK0wB7/1i9
ARC-Seal: i=1; a=rsa-sha256; t=1520550451; cv=none;
        d=google.com; s=arc-20160816;
        b=ZKyfL+p1oaG00C73rmMuPbpJR+zXUdj0TDfGP5sE+6RmT+Hwpwxc/HtbxOEuyZcono
         zvY1pxyhiYx0Qd/s/9cW4M0qYqom3sIKff+MeGF5P9nsjhKd8XFgA/Xk2y8Owd1hxvA1
         w8W29vRsF7IXXyfxMVzg0aJ1yjI10/GcHETvppmD9VKL9BMWsEsy29SRwvCGkwmnIF1S
         gdg3C7qO25TXw21iFp7MK8bUZqZqRLFGdCy7VN8UI1AV7iOWpMSvc9ln+zFlTQzFgXv8
         4WGcmcX5u1ve8NKrxbdN7GtltNR0DpfjzIAEZWt+0zW3JTjlIS0W/BZTTKhRWhR3AGNy
         orCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=ggThZ85XyjEgdzl5cxsQj/p0L4QjrNfvIQ5kK42gC+A=;
        b=VIXmiOUD3MorIqXKRSu786NcX+zHl+p0wIvf3W3MZ9DOGjcrB2RphqTook0Ks1RoC7
         0Czm9PGSddNwKnC30DiC6viow56c3vQm4226+Ut97DRtAMbpN1kk3gr9Q4+BEILFOLDG
         y82G6uoqLujDtP2ZeRF4/jpS+C2riwsleJOCWbMCbEmhDgRFl5XU4+0EsuGEzOAv/z/9
         Q+ANuv3/risU6D8JWJR/ZpVhZXyYCpuF9Z3NicRKor7L9hfA/LyUt1CQgrwT6mZ+3WqU
         QB+8bDpEUS00D7hPhLIhVbTEW5DgGbUsespDxphHPkbjadk0bHYFfehqZXmaIsixv3If
         4G2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=LNHdeXGV;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=KMi8fffc;
       spf=pass (google.com: domain of prvs=66055eecd2=ast@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=66055eecd2=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=LNHdeXGV;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=KMi8fffc;
       spf=pass (google.com: domain of prvs=66055eecd2=ast@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=66055eecd2=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Alexei Starovoitov
	<ast@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
 <20180308012353.GO14069@wotan.suse.de>
CC: <davem@davemloft.net>, <daniel@iogearbox.net>,
        <torvalds@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>,
        Jessica Yu
	<jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki"
	<rjw@rjwysocki.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, Jiri Kosina
	<jikos@kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <d83869b4-260e-179d-d469-83b8d8068399@fb.com>
Date: Thu, 8 Mar 2018 15:07:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180308012353.GO14069@wotan.suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:b108]
X-ClientProxiedBy: MWHPR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:300:13d::13) To SN6PR15MB2510.namprd15.prod.outlook.com
 (2603:10b6:805:25::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c75465-6bcd-47f5-b046-08d585494ffe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2510;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;3:+eQMREbBPW0gDlnfosc0ZWiBY8FeBCJ4F6lmuM7YhSBwcWO7eez2w5HZtiOnI3Bo4CXy6YFa+D+vRPNzOgKDrsGkRW8a3aGNM2qxSvS5QkqkpsljhJRnKHfTo21v7kUok5IthCni7a/utmo99GtosPywrp87hTSCWzDByclnn7XC/Gwtj530HcO7SpsgSdkQa1fredMAybvx73TJ7eI0utZ1xCqnoR0tVfliegWf/EsekBcAD6/eWW/HdQWyVWuN;25:6irITEYxhojKCLFfNGv2ISDyIviOx5JgoFsP3YYyWm750ieKa+tsorFPKqvfdbj1h4jRWvO71MY9EiQCgHYU87c8+5cRmP/pHXtSqm3s2yNeKNeiQr7TkZpjihoxigdiSpLfnpSzzFNwRR23gTMZj89c/nUqcuySTEh3EjDDNq4CLXo6FYX4CZcf7k9F8nIzGdDixspVxpZ+C9HBAoFzvcaL5aNOvR72h83G5ZslKY4aeQHTWh+MuSNHf4LJ0HhG6quy4zpNt35sR6UP3ysfjdDzRJxZ4NTs1VGbS31kOUmmZRjVO/n8R87w0ak+UBSLQ4PE5ONeduM14a1lMnBgLw==;31:2ZH17IyTHLufH46nCVqFGXhYalpMSN4uKgYW/NagI4PRvBqUlv/ggDxOY8tQ5GZSIWEFXzHRSZVmw9sAeLfBSyprSksSbtSNjDtRDqkuq6Vvbi5Q2LRw53gKtpRHTbJolSXRd4gueLFGNdtrFDBV88ACQA7ND4FiwLqIEWapgvUFlFzUeVZT0S576Q4mCeJRAro/p5OekYXVYNr2ewA8OXjtEJ79xxZt+sguy5pr+qY=
X-MS-TrafficTypeDiagnostic: SN6PR15MB2510:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;20:bKeoQw0EJTmrelDJZtwFUvm9iHG62q11eWCDrI2NL7el4BDvbl2HrpNMYse9bmJnKHQ5lJyXfA7rLQK+C6XxH6jIWi+fecf6+7CcyRiL0i0lmJQyuwqK6DM12TZK8OvoG8GKzjp1nQM0OCqMzqDqR5aKsnrVu0fNvN+f4k9ksoD3klf4WsFooY3kbh4KLtos6+T4L2+hBE9ft8bTSwsOKhyjLFROeCFjBhmaTG2GpfQqwgTpjlnVWYttEbPlhBwEUp3FU9YTRdfSs5mzq/MCwOiykDkuICthwM/+ZwY5mR0sIC/Zrzf/fL+G1waw+8yVTHgspRFcuwltk1HVTPcxCF0MItf5y17X+LAQyxFxRW+qDCrzOp7u6f0xiHYjtRO651tUY6WDB0MICqtmK0ruUfo2R0mRON4NSCvb/gxelD6ObY9T3qCXjt8S9rnbL4HsxR7JG6URjIfKoY+PabPYPPKsNgOEpttlDiRvIY1F4zMcHfsoyQR7NntogpCcyqZ6;4:2k3dH020zy4zzCmwyoKunEP4ZDwp9ZPJlyCpVXOiTaarcn4QYGLNXw9nSbDqZYKghEzn3DeS5rxE9TJPBG4LORp/Qq1GxJn1uOAk0Cv8Rlpo8zEoGw5p0JtQ5F6Kedp7Lw9oxDxXu5/Fg+poyM2gypkIyPVJHA4DJVS3ZT/X+HvjKAudjDOf44RbxgSyB6Phe8U/f79t9ECNQcGXY/yHf/t3muwE2//KS4/IoAktefz4vJvvD3Dn2eYiN1b92PiXPfsPNYCUOPixSXP/L3EenA==
X-Microsoft-Antispam-PRVS: <SN6PR15MB25101AC0906A1C84E8C034DFD7DF0@SN6PR15MB2510.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040518)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041306)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN6PR15MB2510;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2510;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39860400002)(346002)(396003)(39380400002)(199004)(189003)(386003)(53546011)(31686004)(59450400001)(186003)(68736007)(4326008)(25786009)(105586002)(230700001)(106356001)(305945005)(6666003)(23746002)(2950100002)(81156014)(6486002)(81166006)(8936002)(7736002)(7416002)(16526019)(65826007)(50466002)(229853002)(64126003)(6246003)(53936002)(5660300001)(8676002)(36756003)(2906002)(97736004)(58126008)(110136005)(52116002)(76176011)(47776003)(31696002)(46003)(54906003)(316002)(478600001)(52396003)(6116002)(65806001)(67846002)(65956001)(86362001)(1706002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2510;H:[IPv6:2620:10d:c081:1131::116e];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN6PR15MB2510;23:gmKjP3H0+cr9EfQW4aaDTZoUWZH2vkrvJNBEQ?=
 =?Windows-1252?Q?6aUuhv16d+pRdfl3TclwP3gCT6mYJRoFj5pz78mVK9qR+lhfdkAzISCa?=
 =?Windows-1252?Q?BtHp4HcwdcIGV817l4D4pU17YsvWnRhd1fnPAK/RCbGhel0pd7d9x+6/?=
 =?Windows-1252?Q?tXNB7bUMsixOJiXn3HJGP3i+rxBuAigVl2gxUYzhX2UhXeGIS3vpIF24?=
 =?Windows-1252?Q?9FkzokMd+0j/TsK7reiFO+eSeIaypiwHbjdug4EKtsiigUbWtYZaHcog?=
 =?Windows-1252?Q?mNIGTxPg8vqSHWlBI9lXZ3Ea7UYkYczgqIazZ2WjTDGxmUgTJsLjhXfg?=
 =?Windows-1252?Q?GX+k/Pm4BTeVB1cVfsT7nmxNns57gLOVvPYZ3oTU7qp2uYtJV6idBL7l?=
 =?Windows-1252?Q?s0IXF368hYXHjaEgJ/W3TdEmdBkQyhJ9S6XrgL/XC7q1w7shSeF0G3H/?=
 =?Windows-1252?Q?h6gWVUcIDaieyhp+3M3kbfs597IaQ5s54GvfVlzj49q6n17NrOQLPSow?=
 =?Windows-1252?Q?ILHeYjxDHUztxcUD78baF23KkbB7B3DvQDt1bKDh+u2A2xdb34wlea2T?=
 =?Windows-1252?Q?5wi9G43Z/QXGtgkrpfz/2c0U0aT6arf/ByoukPzIQONDlrahW3oL2uFu?=
 =?Windows-1252?Q?tKC0YeLFnZPtTqHJUJ7Tyc89HuQIZK6jGKeqTBpQQfJh4iV7QnU7WaEx?=
 =?Windows-1252?Q?wnsmb1EFFOVTT/+DTDLP8YdExybFPIdngwcYfuDAL19WoSiIge6wMbPU?=
 =?Windows-1252?Q?dVUkiUW9J8AVECrYsMQXSErv+LuntoNyv61V9LrA9v05XXi/33/AT13e?=
 =?Windows-1252?Q?u90VVkWi1ROyflwU+xkzh0pfo19MO5eAahMdCuFJUijm9tlewQNFafU0?=
 =?Windows-1252?Q?GJqC1y/A0dYtvBeIFSb6uhEhWagKQhqYo7NwKEwv608EKUqrqlcXjc2y?=
 =?Windows-1252?Q?j2RL0SChpJBnFSvbcOj9A7HNKd3orW/5SEm7z2O6ccesXXJMkHTTFu5H?=
 =?Windows-1252?Q?wf4+WyvwKQIGTaMRSZdIrIV6T8Rqj9uhZx2n09OtqviTEJQbVic5G8gT?=
 =?Windows-1252?Q?etsNQVn6pWrCg/UPeQoyn4uShgxOttCGSLb5Yv1CXLXjx0zy115n2FPy?=
 =?Windows-1252?Q?9KnCY85rd8cWtphTUBt6h9DD5dg8L5pmnaL2FiZexd96IcIYZhwf0hsW?=
 =?Windows-1252?Q?S+iz1IKKg5AYT1SRcaAb7s6OKT51ZP2M5Spwwls+LGJuUKAdRkPxhzQA?=
 =?Windows-1252?Q?/jFFDswaVmmwrIyDNwP19CI3Wo7uTxXP8BCdirQp4P3B/RCp9gXO5JB+?=
 =?Windows-1252?Q?PbrJ1HqI09UVq/5KPCv2gp1eTWsYFt8cFSjMzmkyMe1V7jZjP0NyAJ7W?=
 =?Windows-1252?Q?XT0qvo16FliSXYLuMjfhocrimou64inTq88MZuy6Hx5F9frzYJwBpunD?=
 =?Windows-1252?Q?MEGUZXkmae6j76aM2XuC/nzEr4VE3JgIIvr+vye9rKF3/quPApxwqbFg?=
 =?Windows-1252?Q?JWs5glS+xQCKYASEtSsU4zeCftuNiU9V4Q1ZqCkaB2tnvrw+kiNPSxDu?=
 =?Windows-1252?Q?7MWA8XUg2gDuz8=3D?=
X-Microsoft-Antispam-Message-Info: h85ZiZ3T/+rSrnES4dO635ZocXRjzfyesYC+oQPzoaz4sLz2qc7jjb+7qC5hrGn5RtDv5WbcShdAL68QwUq1v70vafc75SKWxUxEDj80dQ9GvxJpqGjWnSrPvgGNTdUFQyWypn2Sf39nh+6qbE0V3YQCdKUNQxPYE5Iru0j4LsuzEA089JMZV5MnWZBMejTJ
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;6:H58X8ol74dneg+KAYX1MIzmhuXkO2ozNMibfA2Ftp2x1ZLFfhMeMXCRJ26KH1UhXMdKIsBx4dJ2EnjhNx5FOhQF4TDlgcd6AB4xpxGnk2XBkGyJ7U5JVgSAcOdNNFiRea6WhlfJYjVqxpPfgqQMlzPWulBGBtHhQatRYNYp4L+4Tw8/5GXe2ogTKT2r8I2U+kgWXK6Yb47mRgxwusG96J9opd9huefjdXjVaQDlEHlPb36zFUnLzEJ+qp/bqUFNko5Opg9k47rxiVwjKT4c02y1SYnkvAjRi+Y/U5ZTWbIsVhmiHkZW5iRibNWMx9HO3crs9NGxuavA8HUVeiHQ7/PlhIaO2mOuCPn34LVEF7Yg=;5:GhVw8HOnD7sCP6fStR9FVJjQ850psFhcjPEp+ohtTt2rv6i9DJnRMoQxpn1/Qzg5xaca7EKLcFO9B8bZnoNmzzjtJvohao0QKBJ6zKolvXrVTEC3b+O/L77GF6qkoJJ+3d7K3vdaH15LQegKRRoHLYyWwy9yBXz+nrSU8r+LW1U=;24:bfvSbixSsO6xpdQuU1SAfvqQrT1p3qoo4NAn9aetkFOsjIP/TbcYQBPGDyvJQvYfgbXwGIARCYRIy58ctHiIz93n7aWTjZgtuSnLw/YYK1w=;7:iJNpOVYUxyZkQwlnkiPnLS79H5mqCP1NdXFS4IwSLeYTDRvdyERq95cF47Y5lrFro0fOWJEjyxMJFirWhQT6m7oNe0PQNewsbHmkSUIAtm9A7cNON7jgfqOR15AtmTtfEzPuuXiDBXqWzLW8BOinPHa887zSlITtZ1/MYNR7YcT6Vs8iH65pd/pxdh6LHsa1oRBhFcxVLR9YqqIBQqAmEqlq1vE0clowIRGDWnb+jFkHXTKqXPqhixqeh6BAMwyW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;20:6AyNQ0O0HmxImQ6ObExYU9sVuduHD6QYwqQg8mrhzoONbVAk0xXlCotwvv7iHlUmj+7iown0bfz2rfMdiP9fLIrdQ2ucV3cKk3o+28GWeRAWGkQteT10k8GsP08XNbDabetYOYQQDjoYdnqSt0bou6qQswq9ifoaiOKasiWpLnE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 23:07:04.8209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c75465-6bcd-47f5-b046-08d585494ffe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594412710085512517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/7/18 5:23 PM, Luis R. Rodriguez wrote:
>
> request_module() has its own world though too. How often in your proof of
> concept is request_module() called? How many times do you envision it being
> called?

once.

>> +static int run_umh(struct file *file)
>> +{
>> +	struct subprocess_info *sub_info = call_usermodehelper_setup_file(file);
>> +
>> +	if (!sub_info)
>> +		return -ENOMEM;
>> +	return call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC);
>> +}
>
> run_umh() calls the program and waits. Note that while we are running a UMH we
> can't suspend. What if they take forever, who is hosing them down with an
> equivalent:
>
> 	schedule();
> 	try_to_freeze();
>
> Say they are buggy and never return, will they stall suspend, have you tried?
>
> call_usermodehelper_exec() uses helper_lock() which in turn is used for
> umh's accounting for number of running umh's. One of the sad obscure uses
> for this is to deal with suspend/resume. Refer to __usermodehelper* calls
> on kernel/power/process.c
>
> Note how you use UMH_WAIT_EXEC too, so this is all synchronous.

looks like you misread this code and the rest of your concerns
with suspend/resume are not applicable any more.

#define UMH_NO_WAIT     0       /* don't wait at all */
#define UMH_WAIT_EXEC   1       /* wait for the exec, but not the process */
#define UMH_WAIT_PROC   2       /* wait for the process to complete */
#define UMH_KILLABLE    4       /* wait for EXEC/PROC killable */

bpftiler.ko is started once and runs non-stop from there on.
Unless it crashes, but it's a different discussion.

>> +	if (info->hdr->e_type == ET_EXEC) {
>> +#ifdef CONFIG_MODULE_SIG
>> +		if (!info->sig_ok) {
>> +			pr_notice_once("umh %s verification failed: signature and/or required key missing - tainting kernel\n",
>> +				       info->file->f_path.dentry->d_name.name);
>> +			add_taint(TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
>> +		}
>> +#endif
>
> So I guess this check is done *after* run_umh() then, what about the enforce mode,
> don't we want to reject loading at all in any circumstance?

already answered this twice in the thread.
