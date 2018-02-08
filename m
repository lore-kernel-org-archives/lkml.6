Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBHOeE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:34:04 -0500
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com ([104.47.41.60]:13798
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750929AbeBHOeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:34:02 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH v2 1/2] amdgpu/dc/dml: Consolidate redundant CFLAGS
To: Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
References: <20180208015103.169603-1-mka@chromium.org>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <ef9de5a5-a5b3-63a3-7ddb-5d9338019e71@amd.com>
Date: Thu, 8 Feb 2018 09:33:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208015103.169603-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: BN4PR10CA0012.namprd10.prod.outlook.com (10.164.240.22) To
 MWHPR1201MB2479.namprd12.prod.outlook.com (10.172.95.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbdd69aa-12b4-4e2f-c12b-08d56f00fe5e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2479;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2479;3:6uL5+GuxtdMrGixOqx7KLfMrgzTgu9bxUIBR1eZ45SG22j8fCDFiP+z3Irl2fT7XFD6wyy3C1HoL8dBHf0dMKKbeWPzVv2mg1sVBcWePQMkTjGKuaarCkWs0/5n9CSdJvhVxgMkntRQoe1eEAM3BzHYnZDZFVpMnosTH3p4TPFwaAVgdhMJ5nCqblEOTPTJ3UuZG5R/Qx3PmDJqAM95w/VS+9pDz/FRBzpmof18jJKKW0u9uXTM73BvPr6HtuCmZ;25:YrEBWXnybtPUMha5PcmttQdwT5PEUCAF1xy9SiEKBVCHiveFN930QbSfNDr1QaOZMtknsF7OoPryqViFttKqZdl6WmvSP+J9wOzyvvhi1ggvbHNHBw0Chj/OlRwXzQL0gHAALWA8Ln5RoQbtg60IEw0jCKk2k3BWfXmpbyL6q09bVBwlBEmIBCFVWhgJhEWt99i+nxBeQA5+HgcCwfyGj5EN5DFH1iB5md5s/XQ0/42LFIlnYqu7M3ma4akSFOhZbaV78I4zc8mrSGk6IrlxQaE6JWHgmv0Q1gbUwpr7nv8trtN9WqIN2NDEoFhCEX0J539D45V7yLPFbQ0GDbJb6w==;31:8EnkTbdZPQrv4pcCyJnihyWWEEB9waYbD6HKVQ0fUpvnA0sF91pMaRyad6umKQXdIXDSu0zJK97Znuf5fG9Z9M/c+Pp3y91ZaWFoodOuavzXMpSl9EpRfC8I2tkuGgMbBuoNAqw0kVE+rb1psoRfHiaxxWLdmXU4GpZzcWunX5o8z5ZhXKhOG+QkJloJGM0vdAUKP6kIx7IQFSOzr+W5pgz0aXMXzOMFZvGaaHdZBJg=
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2479:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2479;20:IXBl3zWD/XjhQQRjOR8YzsrL4ex7ByLrfRPmnhHeqbs8KgaedjghBHkXXKmY39oxrtB45eseipECLwzd4PyHu2gCDSogiw8NjmmzEmQqW79ryLKodlaq1tiGH9IIAoiM5GighrR9IvByr3QHdgug5vTMpOmF5XOPt2dRmlaW7RcFfnf2ZWGhLrDasRbM4yN31dFKCDjBxlNvDIpEW5/nKcpM3AOpb4QkcJYb0KjUPMmnkB+IJ7MPhzzN59dPM9KGeyAuShEB6unprGyy9+z+lvIpttc9klZjUFKO9VzvN9p6eB98yf9oq5YVFFrPJyaN034Xj/X5Qu0ODJjyTGOklmwLlzf7hQ68+eit4lc+p0XV7rl4pKrph8lLZOJ8G2A9YPWW5rKGz9uoHue83wQWj1IXCbzt39T+d2QSBSa8Ag59d1lP3SNVsScODOQVQUDQzIjXsfGHj6UpZ3VzKBW+biSZUBOuh1cmVv/nJ9eo/0TLn3eHywAlDaAlfTEFkUmv;4:E1wCooJ3zO3IT0xkyIQ013bAN6YkfegrL0/Hd6cyw2kvDM/S+ez+l8ah/+ve2tOC4vkppaP/XdiddNlRAFPTtxTD/juC1pC/lJLaE/1+ZK7NoEtul96SzNEZxT7wKpwScy9dqsW9ELebfP+ETHsll6s2KWoZejGjmI08ay25SwSqERSpStODuyTzShqeNIs+ZiqPzF8pS4IpzhoFKig8vFjKECZtIyuQa8SOm3nLtaGeCPtV0nmXJ+87bnoj9ugz1qofl4BMaoJbj6IOCmuasg==
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24794DFF0288F44CF86435508CF30@MWHPR1201MB2479.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR1201MB2479;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2479;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(377424004)(316002)(58126008)(25786009)(5660300001)(47776003)(65826007)(65956001)(65806001)(66066001)(2906002)(97736004)(478600001)(6246003)(31696002)(81156014)(966005)(81166006)(72206003)(2950100002)(6116002)(3846002)(106356001)(16576012)(86362001)(6666003)(8676002)(6636002)(64126003)(54906003)(36756003)(76176011)(8936002)(229853002)(2870700001)(52116002)(2486003)(31686004)(53546011)(386003)(52146003)(186003)(50466002)(16526019)(105586002)(90366009)(6306002)(77096007)(26005)(68736007)(110136005)(53936002)(83506002)(305945005)(4326008)(6486002)(7736002)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2479;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyMDFNQjI0Nzk7MjM6Zmw1bndqM2JBZzM4WVJNTTdnb1IzL0F1?=
 =?utf-8?B?aE9PZ1owZjJYWk9HOG1JY2pJYjJySnlyQ2pOVm5qaGpib3JLT21qR0Mxdklt?=
 =?utf-8?B?ekphMmM2NjNDc24rODNjZWhzYzdXRXFTUkgxT0xkb1hoUHV0cWpTUWFOUXpL?=
 =?utf-8?B?eDN4elZSbk8vODlJNVJqb2k2VnhKRmwvNURiZUtzYmVUQmN0eFRXem1qcSt4?=
 =?utf-8?B?TGFyZWxQOTl2a09iMWdvVkdOeXVrVUltWXN1c1pHM1IzWVBOMDhsM3pMUGly?=
 =?utf-8?B?cXQ5K0tzdG9KT0VTamJnNG9QaEg5Zlp1VUU0M25KRTR6NnZQT0V2TnJHeEsx?=
 =?utf-8?B?WDQrTFBycFBlYVdVeDFkNm1RTU9HeFN3WVFBOFRoTVh1Y3VqdytWSkMvZldo?=
 =?utf-8?B?R1plTFIyeEVEV0pwek05ZjZvMGlKVTNDc1dUTmYzUWZPVFZqalFyWG5TZDBL?=
 =?utf-8?B?ZW5oYVlGY1VEV0NRdEo0anE2Y1AzdHRqbGF1SzBUdXBRRkFVK1QrbjFFd3M0?=
 =?utf-8?B?WHhTZW5rZXpGT1MrcnRHWHVQZnBVdi93UGk5UFI2WncxZDhmaXh1b0JySXVE?=
 =?utf-8?B?MjNRM1dlaXRLd0V0K0xsRnQ3alNxdGZLSkFKVG9pRk1IMUxGdmYyTThidG1p?=
 =?utf-8?B?T0F1Yzk5SWtQR3MwR21pcnB0bmMvdUxpN2pOMGRDOVpxaHJ5K3c5UW50SHRr?=
 =?utf-8?B?MUhNQkJpcUZyUW03VkFoRFhpOFpFN1VGZ1QrMmZBOUpiUUxNaFVJNHBncXRU?=
 =?utf-8?B?QS8vdndTeHF6dVBMYkY2dDdqS0RDM1AyR3VQbUgvYnVmOWQzRzkrSVVWdXhV?=
 =?utf-8?B?TnF4VFE5MXZld0lOZlJUbkFjdVJmT3ZOOFFDK3U2NHNQQ1NmcCtZekRuYjd1?=
 =?utf-8?B?czVSQm9aM3M3R2pDU281cUJWMzZhMlBlNEJFdDVFUm5rN1BwRjU1ZTNoNFFp?=
 =?utf-8?B?RUpTSGkzc3lQOHNQdmJOTzhjcHpCWnNLUmpPVFlBa3JIVXJEY01OTGpiOU5i?=
 =?utf-8?B?LzJuaFd1R3JqeDJQcXFTL0wvMWdibWZTWUl4ZU0zVzhldHpNYXRKSW9leU1S?=
 =?utf-8?B?bUlDSlRtVFNzQkJMRVBWZXJJMlg3R2xOL2hGSkxRUEl6MmNmK1NndnVFZDhO?=
 =?utf-8?B?azZVRDN5Z3Nlb2h6RVlMWGFCd3o5NlN6aS9USzEvMEJ4QVNJNTdPSWJyUVVs?=
 =?utf-8?B?NnZ3dGdXc29jN1FraW43STdnRTJnUitzLzZtejZ5bGFVREZTaDdwT3A3bllH?=
 =?utf-8?B?UkR6U2wvOER0dENPbDA5NnQ4YXFJZ2pHa2ZmaENnVWpCNmczV2Fud29yMWFT?=
 =?utf-8?B?MFNBM1FEOWpNV05xc1paU0REcUhmeVQvNmY4OFdDQnV6aGZmVmdhVlBFSHh1?=
 =?utf-8?B?WjBKeHlJZVhQT1loYnVWMTFyMTd1T3Q5R09RL1EwYk5VR0hqTSs4QnRnRE5G?=
 =?utf-8?B?YWNHWDg0WXpxd0Q0K0lPaVlSTDltbXFhRGtiUkdLWmU3eXpCQlZQdVlYUi85?=
 =?utf-8?B?d3dBY1RxNzU5c2JwK0NzQ1c3L0JKeW5FeEJmcHdPNjVJYVBaZTVZL0I4R3Jn?=
 =?utf-8?B?UXV6aXNrcjVYN3lHYmp5VjBqZDY0dXR2YmkvQ084eWVWTG9paWowdFdQUmtH?=
 =?utf-8?B?cjVuTk40Qi80c3IwSG1MeE01UjEybTJGQ21vT0xwdmlIa0kybW5kajNXbWds?=
 =?utf-8?B?dXdCUjA3NXY1MTl0dE0yNEJpOHptUTFXYVAxY1JNemVoSm9YMmNiY1RRWFNY?=
 =?utf-8?B?TGlRd2QvOFJkV0ZvL1h4a2dGZ2k4YUR5d0xidWdLeWViRTN1ZHJscnNRbFVx?=
 =?utf-8?B?bWdUMzZmWGE1RXNuUmlqakx0ZWZaZnk3eEhhancwbmVjRGJvNGEwV1hxMmF5?=
 =?utf-8?B?R0hBZjFYa1VaWVp5RUlhOTd1bnJOODJCcHVDNitnR21LZnlNSlgxTElRNWFp?=
 =?utf-8?B?VW4rWVJpbFVuVTErUWZoTS9ONmRQMnJrTFpOUUlaMHU5SmhHTVZ6Nkd6VEtj?=
 =?utf-8?B?OURSbG5MYkZWTko0UDNUSXo0UEFkRHV4bmg5aWRiNjI3dFNNWStBVTZyWGUx?=
 =?utf-8?Q?KGcu+c=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2479;6:KkzNPpQlXCjFpXlf17m8uCHSgjQXzq4n7moiBm4Cnn9Ct4ZUMRG5JH/M9K/H+nOE92/U65hVLSq0lkXhykSn7/ro3Ql/h+5YY4af0QJ4T8Q9FhgMRNqhBFNvTp/CZ27Wd+eX40x5o7OVNGyymdEmcvDNnro/HxL+AklJNnO7aaZUB3mcZoJZ4VoMQAUZ8ERJ2wIiopcqEBea6yRz1U/LfOBTWSBz3eN32ByDhN3M3AH+CMMD+NOS0Th+QXrXh35gbSCuYXGV6PVjk+iAL9zwNPXk18BPEZFeZwCMlFPm4GGBnU75zII5gfcSoJYNBgq7n6iJptXANjjfJ0PJxk+XQqa+KcHjhe23BwM9MoEXNZo=;5:zBNGMjs7gxMdt5ENsIaqogbkSZKNQMfAzTWlcsj/q4yDlT37soHrZFWbuth4G7cDseF0zceHkYblcOda+IC97HjXsQl1FeFqpa1Bs9hPcbFmVghwiCtxbSn3M00EAdz/oY7w5gm73fcV+6iLaPT8RuTpJGc3uZpE8bfY2iWzzsA=;24:BlzLzqvQcJmVd78zU9Qf3N5tF4VUewT1KWHZXWUAtGBZcfTv3QWAKK0Fsj3EJIbn6FhD6sAKoweRl72B3iFpTKuHZBmSrIFaB7UuZO3yF7M=;7:NDItitwOpiglE1vyapkvQcp09DmFGWRGDm1DqvzkwEBYYAKxoyQahzLbh5YYMVVgFbTpAvnxNPGujAugLmG1htOLj/kHngFiriMolu2p2arI9fRQdGfWf8XsUw+0abfaN8vsD7z+kQloHLcvHWic6uGnLncdSIHYgZqLxz5OZqQiDg7ZG25dKB6SvaIZ1pFyvz9nTHxBlGDUtvJ5saqsPOxJl+q4HwHgbBO/al3XhQNHwAYTRliGXG8EsreVw2yA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB2479;20:uLnjCQ3F/n4DUGNyHjIC9r2fymV/3K8RJkZME1Mvgjpa1lRmZEOt0ARRRkYnE/4aHvz/gwohwe7V0mA8kzN25Wii/3yuU8wTSZI6exC/N2aU0gDISuKSruA4qax6YYYfdap5SZQFqSvS76N7oHzSCv2e46ZmJErrxDWuYPFXUGyOuXQgMyXxdm2aF+E1VBLrisU57HyARzEsFsXm/z9UFviy+5FMW+ZWhS9A3tuw0aQ2tmrKSakhJ9sd01bsLof0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 14:33:58.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdd69aa-12b4-4e2f-c12b-08d56f00fe5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2479
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-07 08:51 PM, Matthias Kaehlcke wrote:
> Use subdir-ccflags instead of specifying the same flags for every source
> file.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> ---
> Changes in v2:
> - added 'Reviewed-by: Guenter Roeck <groeck@chromium.org>' tag
> 
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 3488af2b5786..b8cadf833e71 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -24,15 +24,7 @@
>  # It provides the general basic services required by other DAL
>  # subcomponents.
>  
> -CFLAGS_display_mode_vba.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_mode_lib.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_pipe_clocks.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_dml1_display_rq_dlg_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_display_rq_dlg_helpers.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_soc_bounding_box.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_dml_common_defs.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -
> +subdir-ccflags-y += -mhard-float -msse -mpreferred-stack-boundary=4

Are you sure this will only apply to dc/dml?

The way the amdgpu build is setup I've seen this flag apply to all of amdgpu, even if specified in a subdirectories build file. The reason being that amdgpu/Makefile recursively includes all other Makefiles in the module.

According to kbuild/makefiles.txt this will have effect for the kbuild file where it's present and all subdirectories:

https://www.kernel.org/doc/Documentation/kbuild/makefiles.txt:
>     subdir-ccflags-y, subdir-asflags-y
> 	The two flags listed above are similar to ccflags-y and asflags-y.
> 	The difference is that the subdir- variants have effect for the kbuild
> 	file where they are present and all subdirectories.
> 	Options specified using subdir-* are added to the commandline before
> 	the options specified using the non-subdir variants.
> 
> 	Example:
> 		subdir-ccflags-y := -Werror

For your 2nd patch you probably want to make a dml_cflags variable that's set different for clang and gcc, and then still set it for all files in DML individually.

You'll probably also have to do the same for dc/calcs/Makefile.

Thanks for finding a good solution for supporting clang. It's been on my list but I haven't had time to find the right flag yet.

Harry

>  
>  DML = display_mode_lib.o display_rq_dlg_calc.o \
>  	  display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
> 
